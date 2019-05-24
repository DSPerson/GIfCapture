//
//  RecordState.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Foundation

enum RecordState {
    typealias RawValue = Int
    
    case idle
    case start
    case record
    case pause
    case resume
    case stop
    case finsh
}
