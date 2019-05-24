//
//  DSTableView.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/15.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Cocoa

public class DSTableView: NSTableView {
    
    fileprivate var scrollView : NSScrollView!
    fileprivate var tableColumn : NSTableColumn!
    public var dataArray : Array<Any>?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initilize()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initilize()
    }
    private func initilize() {
        headerView = nil
        scrollView = NSScrollView(frame: self.bounds)
        scrollView.documentView = self
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalScroller = true
        scrollView.autoresizesSubviews = true
        scrollView.autoresizingMask = [.width, .height]
        scrollView.verticalScrollElasticity = .allowed
        
        tableColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "TableViewColumn"))
        tableColumn.width = NSWidth(self.bounds)
        addTableColumn(tableColumn)
        
        selectionHighlightStyle = .none
        intercellSpacing = CGSize(width: 0, height: 0)
    }
    
    public func containerView() -> NSScrollView {
        return scrollView
    }
    override public func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
