//
//  TYPlayerViewController.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon Tian on 2023/2/13.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

class TYPlayerViewController: UIViewController {
    
    var urlString : String
    
    private lazy var btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        btn.setTitle("click me", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func btnClick(sender:UIButton) -> Void {
        let player = AVPlayer(url: URL(string: urlString)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = self
        playerViewController.videoGravity = .resizeAspect
        playerViewController.showsPlaybackControls = true
//        present(playerViewController, animated: true)
        self.addChild(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }
        
        playerViewController.player?.play()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
}

extension TYPlayerViewController: AVPlayerViewControllerDelegate {
    func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("willBeginFullScreenPresentationWithAnimationCoordinator")
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("willEndFullScreenPresentationWithAnimationCoordinator")

    }
}
