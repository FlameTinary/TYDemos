//
//  TYCompositionController.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon Tian on 2023/2/16.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import UIKit

class TYCompositionController: UIViewController {
    
    var urlString : String? // 传入的视频链接
    private var nativeUrlStr : String = "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4"; // 本地待合并视频链接
    
    init(urlString: String? = nil) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Composition demo";
    }
}
