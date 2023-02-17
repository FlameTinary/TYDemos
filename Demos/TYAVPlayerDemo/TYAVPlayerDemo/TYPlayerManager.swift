//
//  TYPlayerManager.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon on 2023/2/16.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import Foundation
import AVKit

enum PlayStatus {
    case play
    case pause
}

class TYPlayerManager: NSObject {
    var url : String?
    // 播放器
    private var player : AVPlayer?
    // 播放器layer
    private(set) var playerLayer : AVPlayerLayer?
    // 当前正在播放的item
    private(set) var currentPlayerItem : AVPlayerItem?
    // 播放状态
    private(set) var status : PlayStatus = .pause
    // 播放总时长
    private(set) var duration : Float64 = 0.0
    // 当前播放时间
    private(set) var currentTime : Float64 = 0.0
    
    private(set) var periodicTimeCallback: ((_ currentTime : Float64) -> Void)?
    
    init(url: String? = nil) {
        super.init()
        if let urlString = url {
            self.url = urlString
            let assetKey = [
                "playable",
                "hasProtectedContent"
            ]
//            let asset = AVAsset(url: URL(string: urlString)!)
            let url = URL(fileURLWithPath: urlString)
            let asset = AVAsset(url: url)
            currentPlayerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKey)
            player = AVPlayer(playerItem: currentPlayerItem)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.backgroundColor = UIColor.black.cgColor
            playerLayer?.videoGravity = .resizeAspect
            player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: .main, using: { [weak self](time) in
                // 当前正在播放的时间
                let currentTime = CMTimeGetSeconds(time)
                self?.currentTime = currentTime
//                periodicTime(callback: self?.currentTime)
                self?.periodicTimeCallback?(currentTime)
            })
            addObserverToCurrentPlayerItem()
            addObserverToManager()
        }
    }
    
    deinit {
        removeObserverFromCurrentPlayerItem()
        NotificationCenter.default.removeObserver(self)
    }
    
    // 给当前的playerItem添加监听
    func addObserverToCurrentPlayerItem() {
        // 添加监听，用于监听播放信息
        currentPlayerItem?.addObserver(self, forKeyPath: "status",options: .new, context: nil)
        // 缓存区间，可用来获取缓存了多少
        currentPlayerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 缓存不够了 自动暂停播放
        currentPlayerItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        // 缓存好了 手动播放
        currentPlayerItem?.addObserver(self, forKeyPath:"playbackLikelyToKeepUp", options: .new,context:nil)
    }
    
    // 给当前manager添加监听
    func addObserverToManager() {
        // 音频中断通知
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionInterrupted), name: AVAudioSession.interruptionNotification, object: nil)
        // 音频线路改变（耳机插入、拔出）
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionSilenceSecondaryAudioHint), name: AVAudioSession.silenceSecondaryAudioHintNotification, object: nil)
        // 媒体服务器终止
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionMediaServicesWereLost), name: AVAudioSession.mediaServicesWereLostNotification, object: nil)
        //媒体服务器重启
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionMediaServicesWereReset), name: AVAudioSession.mediaServicesWereResetNotification, object: nil)
        
        // 系统在其空间播放功能发生变化时发布的通知
        if #available(iOS 15.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(audioSessionSpatialPlaybackCapabilitiesChanged), name: AVAudioSession.spatialPlaybackCapabilitiesChangedNotification, object: nil)
        }
        
        //进行跳转
        NotificationCenter.default.addObserver(self, selector: #selector(timeJumped), name: AVPlayerItem.timeJumpedNotification, object: nil)
        //异常中断通知
        NotificationCenter.default.addObserver(self, selector: #selector(playbackStalled), name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
        // 当播放器项目未能播放到其结束时间时系统发布的通知
        NotificationCenter.default.addObserver(self, selector: #selector(failedToPlayToEndTime), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
        // 播放完成
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func removeObserverFromCurrentPlayerItem() {
        currentPlayerItem?.removeObserver(self, forKeyPath: "status")
        currentPlayerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        currentPlayerItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        currentPlayerItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            switch self.player?.currentItem!.status{
            case .readyToPlay:
                //获取播放时长
                duration = CMTimeGetSeconds((self.player?.currentItem!.duration)!)
            case .failed:
                //播放失败
                print("播放失败")
                print(self.player?.currentItem?.error)
            case.unknown:
                //未知情况
                print("unkonwn")
            default: break
            }
        } else if keyPath == "loadedTimeRanges"{
            let loadTimeArray = player?.currentItem!.loadedTimeRanges
            //获取最新缓存的区间
            let newTimeRange : CMTimeRange = loadTimeArray?.first as! CMTimeRange
            let startSeconds = CMTimeGetSeconds(newTimeRange.start);
            let durationSeconds = CMTimeGetSeconds(newTimeRange.duration);
            let totalBuffer = startSeconds + durationSeconds;//缓冲总长度
            print("当前缓冲时间：\(totalBuffer)")
        } else if keyPath == "playbackBufferEmpty"{
            print("正在缓存视频请稍等")
        } else if keyPath == "playbackLikelyToKeepUp"{
            print("缓存好了继续播放")
            player?.play()
        }
    }
    // 播放器周期性调用
    func periodicTime(callback: @escaping (_ currentTime: Float64)->Void) {
        periodicTimeCallback = callback
    }
    func play() {
        player?.play()
        status = .play
    }
    func pause() {
        player?.pause()
        status = .pause
    }
    
    func seek(to time: CMTime) {
        player?.seek(to: time)
    }
    
    @objc func playToEndTime(){
        print("播放完成")
    }
    @objc func failedToPlayToEndTime(){
        print("播放失败")
    }
    @objc func playbackStalled() {
        print("异常中断")
    }
    @objc func timeJumped() {
        print("进行跳转")
    }
    @objc func audioSessionInterrupted() {
        print("音频中断")
    }
    @objc func audioSessionSilenceSecondaryAudioHint() {
        print("音频线路改变（耳机插入、拔出）")
    }
    @objc func audioSessionMediaServicesWereLost() {
        print("媒体服务器终止")
    }
    @objc func audioSessionMediaServicesWereReset() {
        print("媒体服务器重启")
    }
    @objc func audioSessionSpatialPlaybackCapabilitiesChanged() {
        print("空间播放功能发生变化")
    }
}

