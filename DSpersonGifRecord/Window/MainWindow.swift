//
//  MainWindow.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import AppKit

let minWindowWidth : CGFloat = 75
let minWindowHeight: CGFloat = 30

class MainWindow : BaseWindow
{
    fileprivate var sendOnce = false
    fileprivate var lastHeight : CGFloat = 0
    fileprivate var isLonger : Bool = true
    var currentWindowBorderWidth : CGFloat = 1.0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        let dsToolbar = self.toolbar as? DSToolbar
        dsToolbar?.stateDelegate = self
        
    }
    override func setFrameOrigin(_ point: NSPoint) {
        super.setFrameOrigin(point)
    }
    func animationWithFrame(targetFrame : NSRect, complete : @escaping () -> Void) {
        self.alphaValue = 0
        NSAnimationContext.runAnimationGroup({ (c) in
            c.duration = 0.5
            self.animator().alphaValue = 1
            self.animator().setContentSize(NSSize(width: NSWidth(targetFrame), height: NSHeight(targetFrame)))
            self.animator().setFrameTopLeftPoint(NSPoint(x: targetFrame.origin.x, y: targetFrame.origin.y))
        }) {
            complete()
        }
    }
    func animation(newSize : CGSize,duration: TimeInterval = 0.35, complete : @escaping () -> Void) {
        NSAnimationContext.runAnimationGroup({ (c) in
            c.duration = duration
            self.animator().setFrame(NSRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newSize.width, height: newSize.height), display: true)
        }) {
            complete()
        }
    }
}

extension MainWindow : NSWindowDelegate {
    func minWidth(v : CGFloat) -> CGFloat {
        return min(screenWidth, max(v, minWindowWidth))
    }
    func minHeight(v : CGFloat) -> CGFloat {
        return max(v, minWindowHeight)
    }
    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        let width = minWidth(v: frameSize.width)
        let height = minHeight(v: frameSize.height)
        return CGSize(width: width, height: height)
    }
    override func setContentSize(_ size: NSSize) {
        let width = minWidth(v: size.width)
        let height = minHeight(v: size.height)//高度
        super.setContentSize(NSSize(width: width, height: height))
    }
//    func windowDidResize(_ notification: Notification) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: mainWindowResizeMaxHeightRawValue), object: self, userInfo: [mainWindowResizeMaxHeightRawValue : screenHeight, "isLonger" : isLonger])
//    }
}
extension MainWindow : DSToolbarDelegate {
    func dsToolbarRecordStateChange(state: RecordState) {
        print("current state = ", state)
    }
}
