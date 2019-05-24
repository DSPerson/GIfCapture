//
//  BaseWindow.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Cocoa
open class BaseWindow: NSWindow {
    
    /// control can resizable
    var controliIsResizable : Bool = true
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    open override var isResizable: Bool {
        get {
            return controliIsResizable
        }
    }
}


extension NSWindow {
    func lilitePosition() {
        let x = frame.origin.x
        let y = frame.origin.y
        var width : CGFloat = frame.width + 1
        let height = frame.height
        self.setFrame(NSRect(x: x, y: y, width: width, height: height), display: false)
        width -= 1
        self.setFrame(NSRect(x: x, y: y, width: width, height: height), display: false)
    }
    
    /// 保持Window是否在最高层
    ///
    /// - Parameters:
    ///   - keeping: true, 开始保持, false, 正常
    ///   - isMoveable: 是否能移动
    public func keepWindowAlwaysTop(keeping : Bool = true, moveable : Bool = true) {
        if keeping {
            styleMask.remove(.resizable)
            level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.floatingWindow)))

            self.ignoresMouseEvents = true
        } else {
            styleMask.update(with: .resizable)
            isMovableByWindowBackground = true
            level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.normalWindow)))
            self.ignoresMouseEvents = false
        }
        isMovable = moveable
        
    }
    func fadeout(duration : CGFloat = 0.5) {
        let alpha :CGFloat = 1.0
        self.alphaValue = alpha
        self.makeKeyAndOrderFront(self)
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = TimeInterval(duration)
        self.animator().alphaValue = 0
        NSAnimationContext.endGrouping()
    }
    func fadein(duration : CGFloat = 0.5) {
        let alpha :CGFloat = 0
        self.alphaValue = alpha
        self.makeKeyAndOrderFront(self)
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = TimeInterval(duration)
        self.animator().alphaValue = 1.0
        NSAnimationContext.endGrouping()
    }
    func hiddenTitleButton(closeButton : Bool = true, zoomButton : Bool = true, miniaturizeButton : Bool = true) {
        self.standardWindowButton(.closeButton)?.isHidden = closeButton
        self.standardWindowButton(.zoomButton)?.isHidden = closeButton
        self.standardWindowButton(.miniaturizeButton)?.isHidden = closeButton
    }
}
