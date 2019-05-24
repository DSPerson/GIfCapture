//
//  ScreenUtil.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import AppKit
import CoreGraphics

let screenWidth = NSScreen.main!.visibleFrame.width
let screenHeight = NSScreen.main!.visibleFrame.height

let kApp = NSApplication.shared.delegate as! AppDelegate

public struct kWindowListModel {
    var ownName : String
    var bounds  : NSRect
    var pid : pid_t
    init(ownName : String, bounds : NSRect?, pid : pid_t = 0) {
        self.ownName = ownName
        self.pid = pid
        if let b = bounds {
            self.bounds = b
        } else {
            self.bounds = NSRect(x: 0, y: 0, width: 0, height: 0)
        }
    }
}
public class ScreenUtil {
    public class func dockHeight() -> CGFloat {
        return NSScreen.main!.frame.height - NSStatusBar.system.thickness - screenHeight
    }
    public class func convertLeftTopToLeftBottom(rect : CGRect) -> NSRect {
        let height = screenHeight
        let dc = dockHeight()
        let y = height - rect.origin.y + dc + NSStatusBar.system.thickness

        let rs = NSRect(x: rect.origin.x, y: y, width: NSWidth(rect), height: NSHeight(rect))
        return rs
        
    }
    public class func getWindowList(option : CGWindowListOption = [CGWindowListOption.optionAll, CGWindowListOption.optionOnScreenOnly, CGWindowListOption.excludeDesktopElements]) -> Array<kWindowListModel> {
        var array = [Any?]()
        let windowList = CGWindowListCopyWindowInfo(option, kCGNullWindowID)
        array = windowList as? Array<Any> ?? []
        var rs = [kWindowListModel]()
        array.forEach { (dic) in
            if let r = dic as? Dictionary<CFString, Any> {
                let name = r[kCGWindowOwnerName]
                let bounds = r[kCGWindowBounds]
                let boundsc = CGRect(dictionaryRepresentation: bounds as! CFDictionary)
                if let newName = name as? String, newName != "SystemUIServer", newName != "WindowServer", NSHeight(boundsc!) > 22 {
                    let rm = convertLeftTopToLeftBottom(rect: boundsc!)
                    let pid = pid_t(truncating: r[kCGWindowOwnerPID] as! NSNumber)
                    let rsDic = kWindowListModel(ownName: newName, bounds: rm, pid: pid)
                    rs.append(rsDic)
                }
            }
        }
        return rs
    }
    public class func getAppName() -> String {
        let name = Bundle.main.infoDictionary?["CFBundleName"]
        return name as! String
    }
}
