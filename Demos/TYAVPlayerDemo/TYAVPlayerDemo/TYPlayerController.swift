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
        if let layer = playerManager?.playerLayer {
            layer.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 200)
            view.layer.addSublayer(layer)
        }
        playerManager?.periodicTime(callback: {[weak self]currentTime in
            let sliderValue = Float(currentTime/self!.playerManager!.duration)
            self?.progressView.progress = sliderValue
            self?.slider.value = sliderValue
        })
    }
    
    // 配置控制器
    func setup() {
        title = "AVPlayer Demo";
        view.backgroundColor = .white
    }
    
    // 配置子视图
    func setupSubviews() {
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
    }
    
    
    @objc private func btnClick(sender: UIButton) -> Void {
        if sender.tag == 0 {
            playerManager?.play()
        } else if sender.tag == 1 {
            playerManager?.pause()
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        // 调整视频播放进度
        if let pm = playerManager {
            let currentTime = Float64(sender.value) * pm.duration
            let time = CMTimeMake(value: Int64(currentTime), timescale: 1)
            pm.seek(to: time)
        }
    }
    
}
