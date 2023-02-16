//
//  TYPlayerControl.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon on 2023/2/16.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import Foundation

protocol TYPlayerControl: AnyObject {
    // 播放
    func play() ->Void
    // 暂停
    func pause() -> Void
}
