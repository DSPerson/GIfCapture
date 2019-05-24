//
//  ViewController.swift
//  DSpersonGifRecord
//
//  Created by ds on 2019/5/13.
//  Copyright © 2019年 DS. All rights reserved.
//

import Cocoa

let mainWindowResizeMaxHeightRawValue : String = "mainWindowResizeMaxHeightRawValue"

class ViewController: BaseViewController {
    
    @IBOutlet weak var bottomViewLayout: NSLayoutConstraint!
    @IBOutlet weak var bottomBox: NSBox!
    var statusIetm : DSStatusItem = DSStatusItem()
    override func viewDidLoad() {
        super.viewDidLoad()
//        ScreenUtil.getWindowList()
        
        statusIetm.show()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(mainWindowResizeMaxHeight(obj:)), name: NSNotification.Name(rawValue: mainWindowResizeMaxHeightRawValue), object: nil)
        
    }
    @objc
    func mainWindowResizeMaxHeight(obj : Notification) {
        guard let userInfo = obj.userInfo as? [String : Any] else {
            return
        }
        let isLonger = userInfo["isLonger"] as! Bool
        print(isLonger)
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

