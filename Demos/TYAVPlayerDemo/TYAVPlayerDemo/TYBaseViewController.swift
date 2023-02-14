//
//  TYBaseViewController.swift
//  TYAVPlayerDemo
//
//  Created by Sheldon Tian on 2023/2/13.
//  Copyright © 2023 Sheldon. All rights reserved.
//

import UIKit
import SnapKit

class TYBaseViewController: UIViewController {
    
    private var listView:UITableView = {
        let listView = UITableView()
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return listView
    }()


    
    private var modelList = [
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"),
        ListModel(title: "使用AVPlayer播放视频", urlString: "http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4"),
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319104618910544.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/17/mp4/190317150237409904.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4"),
        
        ListModel(title: "简单使用AVPlayerViewController", urlString: "http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4"),
        
    ]
    
    override func viewDidLoad() {
        navigationItem.title = "player list"
        view.backgroundColor = .white
        listView.delegate = self
        listView.dataSource = self
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}

extension TYBaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = model.title
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = model.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelList[indexPath.row]
        if let url = model.urlString {
            var controller : UIViewController
            switch indexPath.row {
            case 0:
                controller = TYPlayerViewController(urlString: url)
            default:
                controller = TYPlayerController(urlString: url)
            }
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}

class ListModel {
    var title:String
    var urlString:String?
    
    init(title: String, urlString: String? = nil) {
        self.title = title
        self.urlString = urlString
    }
}
