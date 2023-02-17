//
//  TYCompositionController.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon Tian on 2023/2/16.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import UIKit
import AVFoundation

class TYCompositionController: UIViewController {
    
    var urlString : String // 传入的视频链接
    private var nativeUrlStr : String = "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4"; // 本地待合并视频链接
    private lazy var btn = {
        let bt = UIButton(type: .system)
        bt.setTitle("合成视频", for: .normal)
        bt.frame = CGRect(x: 100, y: 500, width: 100, height: 44)
        bt.addTarget(self, action: #selector(compositionVideo), for: .touchUpInside)
        return bt
    }()
    private lazy var kDateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
    private lazy var playView = {
        let playView = TYPlayerView()
        playView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 200)
        return playView
    }()
    private var playerManager: TYPlayerManager?

    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Composition demo";
        view.backgroundColor = .white
        view.addSubview(playView)
        view.addSubview(btn)
    }
    
    @objc func compositionVideo() {
        
        let url1 = Bundle.main.path(forResource: "mmj", ofType: ".mp4")
//        playerManager = TYPlayerManager(url: url1)
//        playView.manager = playerManager
//        playerManager!.periodicTime(callback: {[weak self]currentTime in
//            if let weakSelf = self {
//                let sliderValue = Float(currentTime/weakSelf.playerManager!.duration)
//                weakSelf.playView.updateSliderValue(sliderValue)
//            }
//        })
        // 视频资源
        let video1URL = URL(fileURLWithPath: url1!)
        let video2URL = URL(fileURLWithPath: url1!)

        // 创建AVAsset对象
        let videoAsset1 = AVAsset(url: video1URL)
        let videoAsset2 = AVAsset(url: video2URL)

        // 创建AVMutableComposition对象，用于将多个视频合成为一个
        let composition = AVMutableComposition()

        // 创建视频轨道，将视频资源添加到其中
        let videoTrack1 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        try? videoTrack1?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: videoAsset1.duration), of: videoAsset1.tracks(withMediaType: .video)[0], at: .zero)

        let videoTrack2 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        try? videoTrack2?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: videoAsset2.duration), of: videoAsset2.tracks(withMediaType: .video)[0], at: videoAsset1.duration)

        // 导出合成后的视频
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
//        let outputURL = URL(fileURLWithPath: "path/to/output.mp4")
        let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("output.mp4")
        print(outputURL!)
        exportSession?.outputURL = outputURL
        exportSession?.outputFileType = .mp4
        exportSession?.exportAsynchronously(completionHandler: {
            if exportSession?.status == .completed {
                print("视频合成并导出成功！")
            } else if exportSession?.status == .failed {
                print("视频合成并导出失败：\(exportSession?.error?.localizedDescription ?? "")")
            }
        })
    }
}
