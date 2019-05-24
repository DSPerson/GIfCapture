//
//  StatusControlManager.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/15.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Foundation

protocol StatusControlManagerDelegate: class {
    func recordStateChange()
    func didSelectAppForRecord(select : kWindowListModel)
}
class StatusControlManager {
    static let share = StatusControlManager()
    var savePath : String = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .userDomainMask, true).last!
    var state : RecordState = .idle {
        didSet {
            StatusControlManager.share.delegate?.recordStateChange()
        }
    }
    weak var delegate : StatusControlManagerDelegate?
}
