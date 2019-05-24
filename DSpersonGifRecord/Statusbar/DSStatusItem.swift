//
//  DSSatusbar.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/15.
//  Copyright © 2019 DSperson. All rights reserved.
//

import AppKit

class DSStatusItem : NSObject{
    fileprivate lazy var statusItem : NSStatusItem = {
        let s = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        return s
    }()
    fileprivate lazy var windowView : NSPopover = {
       let v = NSPopover()
        v.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        v.contentViewController = StatusViewController()
        v.contentSize = CGSize(width: 100, height: 315)
        v.behavior = NSPopover.Behavior.transient
        return v
    }()
    fileprivate var isShow : Bool = false
    fileprivate var button : NSStatusBarButton!
    var isKeep : Bool = false {
        willSet {
            if newValue {
                self.windowView.behavior = NSPopover.Behavior.applicationDefined
            } else {
                self.windowView.behavior = NSPopover.Behavior.transient
            }
        }
    }
    func show() {
        button = statusItem.button!
        button.target = self
        button.action = #selector(statusBarButtonAction(button:))
        button.image = NSImage(named: "start_toolbar")
    }
    
    @objc
    func statusBarButtonAction(button: NSStatusBarButton) {
        let frame = kApp.mainWindow.frame
        let x = NSWidth(frame)
        let y = NSHeight(frame) / 2.0
        windowView.show(relativeTo: CGRect(x: x, y: y, width: 0, height: 0), of: kApp.mainWindow.contentView!, preferredEdge: NSRectEdge.maxX)
       
        NSApp.activate(ignoringOtherApps: true)
        kApp.mainWindow.orderFront(nil)
    }
    func close() {
        windowView.close()
    }
}

