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
    
    private lazy var playView = {
        let playView = TYPlayerView()
        playView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 200)
        view.addSubview(playView)
        return playView
    }()
    private var playerManager: TYPlayerManager?
    
    init(urlString : String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        playerManager = TYPlayerManager(url: urlString)
        playView.manager = playerManager
        playerManager!.periodicTime(callback: {[weak self]currentTime in
            if let weakSelf = self {
                let sliderValue = Float(currentTime/weakSelf.playerManager!.duration)
                weakSelf.playView.updateSliderValue(sliderValue)
            }
        })
    }
    // 配置控制器
    func setup() {
        title = "AVPlayer Demo";
        view.backgroundColor = .white
    }
}
