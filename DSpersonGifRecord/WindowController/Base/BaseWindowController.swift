//
//  BaseWindowController.swift
//  DSpersonGifRecord
//
//  Created by ds on 2019/5/13.
//  Copyright © 2019年 DSperson. All rights reserved.
//

import Cocoa

open class BaseWindowController: NSWindowController {
    
    
    override open func windowDidLoad() {
        super.windowDidLoad()
//        self.window?.makeFirstResponder(self)
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        window?.isMovableByWindowBackground = true
    }
    
}
