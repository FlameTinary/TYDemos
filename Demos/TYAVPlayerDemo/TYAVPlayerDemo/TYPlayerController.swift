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
    
    private var player : AVPlayer?
    private var playerLayer : AVPlayerLayer?
    
    init(urlString : String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "AVPlayer Demo";
        view.backgroundColor = .white
        
        view.addSubview(playBtn)
        view.addSubview(pauseBtn)
        
        playBtn.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view).offset(-50)
        }
        
        pauseBtn.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view).offset(50)
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
        view.layer.addSublayer(playerLayer!)
    }
    
    @objc private func btnClick(sender: UIButton) -> Void {
        if sender.tag == 0 {
            player?.play()
        } else if sender.tag == 1 {
            player?.pause()
        }
    }
}
