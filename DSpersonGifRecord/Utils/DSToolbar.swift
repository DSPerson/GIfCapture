//
//  DSToolbar.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Cocoa

let recordIndetifier : NSToolbarItem.Identifier = NSToolbarItem.Identifier(rawValue: "recordIndetifier")
let stopIndetifier : NSToolbarItem.Identifier = NSToolbarItem.Identifier(rawValue: "stopIndetifier")
let windowListIndetifier : NSToolbarItem.Identifier = NSToolbarItem.Identifier(rawValue: "windowListIndetifier")

protocol DSToolbarDelegate {
    func dsToolbarRecordStateChange(state : RecordState)
}
class DSToolbar: NSToolbar {
    
    fileprivate var recordItem : NSToolbarItem!
    var recordState : RecordState = .idle
    var stateDelegate: DSToolbarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        self.displayMode = .iconOnly
        allowsUserCustomization = false
        showsBaselineSeparator = true
        
        insertItem(withItemIdentifier: recordIndetifier, at: 0)
        insertItem(withItemIdentifier: stopIndetifier, at: 1)
        insertItem(withItemIdentifier: NSToolbarItem.Identifier.flexibleSpace, at: 2)
        insertItem(withItemIdentifier: windowListIndetifier, at: 3)
    }
    
    
}
extension DSToolbar : NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let item : NSToolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        switch itemIdentifier {
        case recordIndetifier:
            item.image = NSImage(named: "start_toolbar")
            item.action = #selector(record)
            recordItem = item
        case stopIndetifier:
            item.image = NSImage(named: "stop_toolbar")
            item.action = #selector(record)
            break
        case NSToolbarItem.Identifier.flexibleSpace:
            print("ccc")
            
            break
        default:
            break
        }
        item.isEnabled = true
        item.target = self
        return item
    }
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [recordIndetifier]
    }
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [stopIndetifier]
    }
    @objc
    func record() {
        switch recordState {
        case .idle:
            recordState = .start
            break
        case .record:
            recordState = .pause
            break
        case .pause:
            recordState = .resume
            break
        default:
            return;
        }
        self.stateDelegate?.dsToolbarRecordStateChange(state: recordState)
    }
    @objc
    func stopRecord() {
        switch recordState {
        case .record:
            recordState = .stop
            break;
        default:
            return;
        }
        self.stateDelegate?.dsToolbarRecordStateChange(state: recordState)
    }
}
