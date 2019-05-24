//
//  Color.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import AppKit

public func ds_color(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) -> NSColor {
    return NSColor(deviceRed: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}



