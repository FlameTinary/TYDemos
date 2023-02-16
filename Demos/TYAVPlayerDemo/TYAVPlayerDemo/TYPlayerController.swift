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
        setupSubviews()
        
        playerManager = TYPlayerManager(url: urlString)
        self.playView.manager = playerManager
        if let layer = playerManager?.playerLayer {
            layer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
            playView.layer.insertSublayer(layer, at: 0)
        }
        playerManager?.periodicTime(callback: {[weak self]currentTime in
            let sliderValue = Float(currentTime/self!.playerManager!.duration)
            self?.playView.updateSliderValue(sliderValue)
        })
    }
    
    // 配置控制器
    func setup() {
        title = "AVPlayer Demo";
        view.backgroundColor = .white
    }
    
    // 配置子视图
    func setupSubviews() {
        view.addSubview(playView)
        
        playView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(100)
            make.height.equalTo(200)
        }
    }
    
}
