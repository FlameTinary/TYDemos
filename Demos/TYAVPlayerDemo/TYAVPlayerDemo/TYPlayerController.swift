//
//  TYPlayerController.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon Tian on 2023/2/13.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

class TYPlayerController : UIViewController {
    
    var urlString : String
    
    private lazy var playBtn = {
        let btn = UIButton(type: .system)
        btn.tag = 0
        btn.setTitle("play", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var pauseBtn = {
        let btn = UIButton(type: .system)
        btn.tag = 1
        btn.setTitle("pause", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var progressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.0
        return progressView
    }()
    
    private lazy var slider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    private var player : AVPlayer?
    private var playerLayer : AVPlayerLayer?
    private var duration : Float64 = 0.0
    
    init(urlString : String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        player?.currentItem!.removeObserver(self, forKeyPath: "status")
        player?.currentItem!.removeObserver(self, forKeyPath: "loadedTimeRanges")
        player?.currentItem!.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        player?.currentItem!.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        title = "AVPlayer Demo";
        view.backgroundColor = .white
        
        view.addSubview(playBtn)
        view.addSubview(pauseBtn)
        view.addSubview(progressView)
        view.addSubview(slider)
        
        progressView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(300)
        }
        
        playBtn.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view).offset(-50)
        }
        
        pauseBtn.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view).offset(50)
        }
        
        slider.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(-30)
            make.height.equalTo(10)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
        }
        
        let assetKey = [
            "playable",
            "hasProtectedContent"
        ]
        
        let asset = AVAsset(url: URL(string: urlString)!)
        
        let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKey)
        
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer!.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 200)
        playerLayer!.backgroundColor = UIColor.black.cgColor
        playerLayer?.videoGravity = .resizeAspect
        view.layer.addSublayer(playerLayer!)
        
        // 添加监听，用于监听播放信息
        playerItem.addObserver(self, forKeyPath: "status",options: .new, context: nil)
        // 缓存区间，可用来获取缓存了多少
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 缓存不够了 自动暂停播放
        playerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        // 缓存好了 手动播放
        playerItem.addObserver(self, forKeyPath:"playbackLikelyToKeepUp", options: .new,context:nil)
        
        player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: .main, using: { [weak self](time) in
            // 当前正在播放的时间
            let currentTime = CMTimeGetSeconds(time)
            //获取播放总时长
//            let duration = CMTimeGetSeconds((self?.player?.currentItem!.duration)!)
            // 时间比例
            if let duration = self?.duration {
                let sliderValue = Float(currentTime/duration)
                self?.progressView.progress = sliderValue
                self?.slider.value = sliderValue
            }
            
        })
        /**
         //音频中断通知
         AVAudioSessionInterruptionNotification
         //音频线路改变（耳机插入、拔出）
         AVAudioSessionSilenceSecondaryAudioHintNotification
         //媒体服务器终止、重启
         AVAudioSessionMediaServicesWereLostNotification
         AVAudioSessionMediaServicesWereResetNotification
         //其他app的音频开始播放或者停止时
         AVAudioSessionSilenceSecondaryAudioHintNotification
         
         //播放结束
         AVPlayerItemDidPlayToEndTimeNotification
         //进行跳转
         AVPlayerItemTimeJumpedNotification
         //异常中断通知
         AVPlayerItemPlaybackStalledNotification
         //播放失败
         AVPlayerItemFailedToPlayToEndTimeNotificati
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    
    
    @objc private func btnClick(sender: UIButton) -> Void {
        if sender.tag == 0 {
            player?.play()
        } else if sender.tag == 1 {
            player?.pause()
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
//        print("Slider value: \(sender.value)")
        // 调整视频播放进度
        let currentTime = Float64(sender.value) * duration
        let time = CMTimeMake(value: Int64(currentTime), timescale: 1)
        player?.seek(to: time)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            switch self.player?.currentItem!.status{
            case .readyToPlay:
                //获取播放时长
                duration = CMTimeGetSeconds((self.player?.currentItem!.duration)!)
            case .failed:
                //播放失败
                print("failed")
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
    
    
       
       @objc func playToEndTime(){
           print("播放完成")
       }
}
