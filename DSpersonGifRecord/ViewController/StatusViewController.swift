//
//  StatusViewController.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/15.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Cocoa


public class StatusViewController: BaseViewController {
    let width : CGFloat = 100
    let height : CGFloat = 315
    let menuHeight : CGFloat = 75
    let cellHeight : CGFloat = 25
    var tableView : DSTableView!
    var dataArray : Array = [kWindowListModel]()
    
    lazy var recordButton : SYFlatButton = { [unowned self]() -> SYFlatButton in
        let record = SYFlatButton(frame: NSRect(x: 0, y: 0, width: 40, height: 20))
        record.title = "开始"
        return record
    }()
    lazy var stopButton : SYFlatButton = { [unowned self]() -> SYFlatButton in
        let record = SYFlatButton(frame: NSRect(x: 0, y: 0, width: 40, height: 20))
        record.title = "停止"
        return record
        }()
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.view.window?.makeFirstResponder(self)
        
        
        tableView = DSTableView(frame: NSRect(x: 0, y: 0, width: width, height: height - menuHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.containerView().drawsBackground = false
        tableView.containerView().contentView.backgroundColor = NSColor.clear
        tableView.backgroundColor = NSColor.clear
        view.addSubview(tableView.containerView())
        subButtons()
    }
    public override func viewWillAppear() {
        super.viewWillAppear()
        self.view.becomeFirstResponder()
        dataArray = ScreenUtil.getWindowList()
        tableView.reloadData()
        viewWillApperaCacuate(toDelegate: false)
    }
    private func subButtons() {
        let space : CGFloat = 15.0
        let y : CGFloat = 10.0
        let buttonHeight : CGFloat = 25.0
        let tableViewY = NSHeight(tableView.containerView().frame)
        
        recordButton.frame = CGRect(x: space, y: tableViewY + y, width: width - 2 * space, height: buttonHeight)
        recordButton.action = #selector(recordButtonAction)
        
        btCommonProperty(record: recordButton)
        view.addSubview(recordButton)
        
        stopButton.frame = CGRect(x: space, y: NSMaxY(recordButton.frame) + y, width: width - 2 * space, height: buttonHeight)
        stopButton.action = #selector(stopButtonAction)
        btCommonProperty(record: stopButton)
        view.addSubview(stopButton)
    }
    private func btCommonProperty(record : SYFlatButton) {
        record.borderNormalColor = NSColor.white
        record.titleNormalColor = NSColor.white
        record.titleHighlightColor = NSColor.white
        record.onAnimateDuration = 0.3
        record.borderWidth = 0.5
        record.cornerRadius = 3
        record.borderNormalColor = NSColor.white
        record.borderHighlightColor = NSColor.white
        record.target = self
    }
    func viewWillApperaCacuate(toDelegate : Bool = true) {
        switch StatusControlManager.share.state {
        case .idle:
            recordButton.title = "开始"
            if toDelegate {
                StatusControlManager.share.state = .start
            }
            
            break
        case .record:
            recordButton.title = "暂停"
            if toDelegate {
                StatusControlManager.share.state = .pause
            }
            break
        case .pause:
            recordButton.title = "恢复"
            if toDelegate {
                StatusControlManager.share.state = .resume
            }
            break
        default:
            return
        }
    }
    @objc
    func recordButtonAction() {
        viewWillApperaCacuate(toDelegate: true)
    }
    @objc
    func stopButtonAction() {
        StatusControlManager.share.state = .stop
        recordButton.title = "转换中"  
    }
}
extension StatusViewController : NSTableViewDelegate, NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return dataArray.count
    }
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if row < dataArray.count {
            return dataArray[row]
        }
        return nil
        
    }
    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell : StatusTableViewCell
        if let newCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("windowList"), owner: self) as? StatusTableViewCell {
            cell = newCell
        } else {
            cell = StatusTableViewCell(frame: NSRect(x: 0, y: 0, width: width, height: cellHeight))
        }
        cell.backgroundColor = NSColor.clear
        if row < dataArray.count {
            cell.updateValue(dic: dataArray[row])
        }
        return cell
    }
    public func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return cellHeight
    }
    public func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        guard row >= 0, dataArray.count > row, StatusControlManager.share.state == .idle else {
            tableView.deselectAll(nil)
            return
        }
        let dic = dataArray[row]
        StatusControlManager.share.delegate?.didSelectAppForRecord(select: dic)
        tableView.deselectAll(nil)
    }
}
