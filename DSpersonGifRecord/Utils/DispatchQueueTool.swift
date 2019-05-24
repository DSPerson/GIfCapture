//
//  DispatchQueueTool.swift
//  DSpersonGifRecord
//
//  Created by ds on 2019/5/18.
//  Copyright © 2019年 DSperson. All rights reserved.
//

import Foundation

public func DispatchAfter(timer : TimeInterval, complete : (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timer) {
        complete?()
    }
}
