//
// TYAboutSwiftVC.swift
// TYToolSet
//
// Created by Sheldon on 2018/12/6.
// GitHub: https://github.com/FlameTinary
// Copyright © 2018 Sheldon. All rights reserved.
//

import UIKit

class TYAboutSwiftVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
        
        let lbl = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 44))
        lbl.text = "这是一个Swift页面"
        self.view.addSubview(lbl)
        
        let btn = UIButton.init(type: UIButton.ButtonType.system)
        btn.frame = CGRect.init(x: 100, y: 200, width: 100, height: 44)
        btn.setTitle("跳转OC页面", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.green, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btn.addTarget(self, action: #selector(btnClick(button:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
        // Do any additional setup after loading the view.
    }
    

    @objc func btnClick(button:UIButton) {
        print("btn Did Click")
        let photo = TYPhotoPickerController.init()
        self.navigationController?.pushViewController(photo, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
