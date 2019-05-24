//
//  MainView.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/14.
//  Copyright © 2019 DSperson. All rights reserved.
//

import AppKit

class MainView : NSView {
    @IBInspectable var backgroundColor : NSColor?
    
    var frameSizeChange : ((_ newSize : CGSize) -> Void)?
    override var isFlipped: Bool {
        return true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if backgroundColor != nil {
            backgroundColor?.setFill()
            dirtyRect.fill()
        }
    }
    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        frameSizeChange?(newSize)
    }
//    override func scrollWheel(with event: NSEvent) {
//        super.scrollWheel(with: event)
//    }
}
