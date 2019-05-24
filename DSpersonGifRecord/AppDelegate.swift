//
//  AppDelegate.swift
//  DSpersonGifRecord
//
//  Created by ds on 2019/5/13.
//  Copyright © 2019年 DS. All rights reserved.
//

import Cocoa
import AppKit
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindow : MainWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let cc = NSApplication.shared.windows.filter { (w) -> Bool in
            return w.isKind(of: MainWindow.self)
        }
        guard let window = cc.first as? MainWindow else {
            return
        }
        mainWindow = window
        ///////// 将Window 变为透明
        mainWindow.isOpaque = false
        mainWindow.backgroundColor = NSColor.clear
        /////////
        mainWindow.contentView?.wantsLayer = true
        mainWindow.contentView?.layer?.borderColor = NSColor.green.cgColor
        mainWindow.contentView?.layer?.borderWidth = mainWindow.currentWindowBorderWidth
//        mainWindow.hasShadow = false
    }
    func cacluateStatusBar() {
//        var statusBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}

