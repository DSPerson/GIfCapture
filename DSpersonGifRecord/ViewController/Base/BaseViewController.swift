//
//  BaseViewController.swift
//  DSpersonGifRecord
//
//  Created by ds on 2019/5/13.
//  Copyright © 2019年 DSperson. All rights reserved.
//

import Cocoa

open class BaseViewController: NSViewController {
    
    public override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
      
    }
    
}

extension BaseViewController {
    public convenience init() {
        self.init(nibName: "BaseViewController", bundle: nil)
    }
}
