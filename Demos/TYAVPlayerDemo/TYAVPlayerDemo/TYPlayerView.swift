//
//  TYPlayerView.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon Tian on 2023/2/16.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

class TYPlayerView: UIView {
    
    weak var manager: TYPlayerManager? {
        didSet {
            if let layer = manager?.playerLayer {
                layer.frame = self.bounds
                self.layer.insertSublayer(layer, at: 0)
            }
        }
    }
    
    private lazy var playBtn = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "pause"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var slider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func btnClick(sender: UIButton) -> Void {
        if let pm = manager {
            switch pm.status {
            case .play :
                pm.pause()
                sender.setImage(UIImage(systemName: "play"), for: .normal)
            case .pause :
                pm.play()
                sender.setImage(UIImage(systemName: "pause"), for: .normal)
            }
            
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        // 调整视频播放进度
        if let pm = manager {
            let currentTime = Float64(sender.value) * pm.duration
            let time = CMTimeMake(value: Int64(currentTime), timescale: 1)
            pm.seek(to: time)
        }
    }
    
    //更新slider value
    func updateSliderValue(_ value: Float){
        slider.value = value
    }
    
    // 配置子视图
    func setupSubviews() {
        addSubview(playBtn)
        addSubview(slider)
        
        playBtn.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        slider.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
        }
    }
}
