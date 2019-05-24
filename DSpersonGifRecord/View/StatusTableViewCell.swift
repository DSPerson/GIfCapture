//
//  StatusTableViewCell.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/15.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Cocoa

class StatusTableViewCell: MainView {
    lazy var titleLabel : NSLabel = {
       let label = NSLabel(frame: NSRect(x: 0, y: 0, width: 0, height: 0))
        label?.textColor = NSColor.white
        label?.textAlignment = NSTextAlignment.center
        return label!
    }()
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(titleLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        titleLabel.frame = NSRect(x: 4, y: 0, width: NSWidth(self.bounds), height: NSHeight(self.bounds))
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    func updateValue(dic : kWindowListModel) {
        
        titleLabel.text = dic.ownName
//        print(titleLabel.text)
    }
}
