//
//  Utils.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/20.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Foundation
struct Utils {
    static let formatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
        return formatter
    }()
    
    static func fileExits(atPath : String, isDirectory : Bool) -> Bool {
        var isDir : ObjCBool = false
        if FileManager.default.fileExists(atPath: atPath, isDirectory: &isDir) {
            return isDir.boolValue
        }
        return false
    }
}
