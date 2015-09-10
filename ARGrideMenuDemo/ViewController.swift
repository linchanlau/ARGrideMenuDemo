//
//  ViewController.swift
//  ARGrideMenuDemo
//
//  Created by 刘淋全 on 15/9/10.
//  Copyright (c) 2015年 刘淋全. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ARGridMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var menu:ARGridMenu=ARGridMenu(orginY: 100, titleArr: ["PAG1","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4"], imageArr: ["PAG1","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4"])
        menu.delegate=self
        self.view.addSubview(menu)
        
    }
    
    func selectedWithIndex(index: Int) {
        var alertControl:UIAlertController=UIAlertController(title: "恭喜", message: "点击了第\(index)个", preferredStyle: UIAlertControllerStyle.Alert)
        var okBtn:UIAlertAction=UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: nil)
        var cancleBtn:UIAlertAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertControl.addAction(okBtn)
        alertControl.addAction(cancleBtn)
        self.presentViewController(alertControl, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

