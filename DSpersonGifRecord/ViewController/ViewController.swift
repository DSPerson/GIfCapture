//
//  ViewController.swift
//  DSpersonGifRecord
//
//  Created by ds on 2019/5/13.
//  Copyright © 2019年 DS. All rights reserved.
//

import Cocoa

let mainWindowResizeMaxHeightRawValue : String = "mainWindowResizeMaxHeightRawValue"

class ViewController: BaseViewController, NSControlTextEditingDelegate, NSTextFieldDelegate {
    let kBottomHeight : CGFloat = 30
    let kBottomSubViewidth : CGFloat = 120.0
    var bottomView: MainView!
    var bottomSubView : MainView!
    var statusIetm : DSStatusItem = DSStatusItem()
    var widthTextField : NSTextField!
    var heightTextField : NSTextField!
    fileprivate var capture : ScreenCapture?
    fileprivate lazy var hud : NSProgressIndicator = { [weak self] () ->  NSProgressIndicator in
        let width : CGFloat = 16
        let hud = NSProgressIndicator(frame: NSRect(x: 0, y: 0, width: width, height: width))
        hud.controlSize = NSControl.ControlSize.small
        hud.style = NSProgressIndicator.Style.spinning
        hud.sizeToFit()
        self?.bottomView.addSubview(hud)
        return hud
    }()
    fileprivate func newuHud(newX : CGFloat = 0) {
        let width : CGFloat = 16
        let position = width + 14
        var x = NSWidth(self.bottomView.frame) - position
        if newX != 0 {
            x = newX - position
        }
        let y = (NSHeight(self.bottomView.frame) - width) / 2.0
        hud.frame = NSRect(x: x, y: y, width: width, height: width)
        startHud()
    }
    fileprivate func startHud(show : Bool = true) {
         hud.isHidden = !show
        if show {
            hud.startAnimation(nil)
        } else {
            hud.stopAnimation(nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        statusIetm.show()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(mainWindowResizeMaxHeight(obj:)), name: NSNotification.Name(rawValue: mainWindowResizeMaxHeightRawValue), object: nil)
        cacluateBottomView()
        StatusControlManager.share.delegate = self
    }
    override func viewWillLayout() {
        super.viewWillLayout()
        bottomView.frame = NSRect(x: 0, y: NSHeight(view.bounds) - kBottomHeight, width: NSWidth(view.bounds), height: kBottomHeight)
        resizeContentViewForDisplay()
    }
    @objc
    func mainWindowResizeMaxHeight(obj : Notification) {
        guard let userInfo = obj.userInfo as? [String : Any] else {
            return
        }
        let isLonger = userInfo["isLonger"] as! Bool
        print(isLonger)
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    func cacluateBottomView() {
        bottomView = MainView(frame: NSRect(x: 0, y: NSHeight(view.bounds) - kBottomHeight, width: NSWidth(view.bounds), height: kBottomHeight))
        bottomView.backgroundColor = NSColor.white
        view.addSubview(bottomView)
        
        bottomSubView = MainView(frame: NSRect(x: 0, y: 0, width: kBottomSubViewidth, height: kBottomHeight))
        bottomView.addSubview(bottomSubView)
        bottomView.backgroundColor = NSColor.white
        
        let left : CGFloat = 10.0
        let y : CGFloat = 5.0
        
        widthTextField = NSTextField(frame: NSRect(x: left, y: y, width: 50, height: kBottomHeight - 2 * y))
        widthTextField.isBordered = false
        widthTextField.tag = 1000
//        widthTextField.target = self
        widthTextField.delegate = self
        bottomSubView.addSubview(widthTextField)
        
        let x = NSLabel(frame: NSRect(x: NSMaxX(widthTextField.frame) + 5, y: kBottomHeight - 10 * 2, width: 10, height: 10))
        x?.text = "x"
        x?.textAlignment = .center
        bottomSubView.addSubview(x!)
        
        heightTextField = NSTextField(frame: NSRect(x: NSMaxX(x!.frame) + 5, y: y, width: 50, height: kBottomHeight - 2 * y))
        heightTextField.isBordered = false
//        heightTextField.target = self
        heightTextField.tag = 1001
        heightTextField.delegate = self
        bottomSubView.addSubview(heightTextField)
    }
    func resizeContentViewForDisplay() {
        widthTextField.stringValue = "\(NSWidth(view.bounds))"
        heightTextField.stringValue = "\(NSHeight(view.bounds))"
    }
    func controlTextDidChange(_ obj: Notification) {
        guard let object = obj.object as? NSTextField else {
            return
        }
        let sv = object.stringValue
        let bv = Double(sv)
        let value = CGFloat(bv ?? 0)
        if object.tag == 1000 {
            let v = kApp.mainWindow.minWidth(v: value)
            if value > v {
                object.stringValue = "\(v)"
            }
            kApp.mainWindow.setContentSize(CGSize(width: value, height: kApp.mainWindow.frame.width))
        } else {
            kApp.mainWindow.setContentSize(CGSize(width: kApp.mainWindow.frame.width, height:value))
        }
    }
    func getCaputreRect() -> NSRect {
        let frame = self.view.window!.frame
        return frame
    }
}

extension ViewController : StatusControlManagerDelegate {
    func didSelectAppForRecord(select: kWindowListModel) {
        let bounds = select.bounds
        
        guard let application = NSRunningApplication(processIdentifier: select.pid), let identifier = application.bundleIdentifier else {
            return
        }
        ///激活其他APP
        kApp.mainWindow.animationWithFrame(targetFrame: bounds) {
            DispatchAfter(timer: 0.2) {
                self.statusIetm.isKeep = true
                let _ = NSWorkspace.shared.launchApplication(withBundleIdentifier: identifier, options: [.async], additionalEventParamDescriptor: nil, launchIdentifier: nil)
                DispatchAfter(timer: 0.2) {
                    NSWorkspace.shared.launchApplication(ScreenUtil.getAppName())
                    kApp.mainWindow.makeKeyAndOrderFront(nil)
                    self.resizeContentViewForDisplay()
                    self.statusIetm.isKeep = false
                }
            }
        }
    
    }
    
    func recordStateChange() {
        switch StatusControlManager.share.state {
        case .idle:
            bottomView(isShow: true)
            break
        case .start:
            bottomView(isShow: false)
             self.statusIetm.close()
            capture = ScreenCapture(rect: self.getCaputreRect(), delegate: self)
            capture?.record()
            break
        case .record:
            break
        case .pause:
            capture?.pause()
            break
        case .resume:
            capture?.resume()
            break
        case .stop:
            bottomView(isShow: true)
            capture?.stop()
            var width = NSWidth(self.view.bounds)
            if width <= 250 {
                kApp.mainWindow.animation(newSize: CGSize(width: 250, height: NSHeight(self.view.bounds))) {
                    
                }
                width = 250
            }
            newuHud(newX: width)
        case .finsh:
            StatusControlManager.share.state = .idle
            startHud(show: false)
            break
        }
        statusIetm.close()
    }
    private func bottomView(isShow : Bool) {
        
        bottomView.isHidden = !isShow
        if isShow {
            bottomView.backgroundColor = NSColor.white
            self.view.window?.keepWindowAlwaysTop(keeping: false, moveable: true)
        } else {
            bottomView.backgroundColor = NSColor.clear
            self.view.window?.keepWindowAlwaysTop(keeping: true, moveable: false)
            kApp.mainWindow.orderBack(self)
        }
        self.view.window?.hiddenTitleButton(closeButton: !isShow, zoomButton: !isShow, miniaturizeButton: !isShow)
        //FIXME: 此处不移动会有一条无法隐藏的线....
        view.window?.lilitePosition()
        kApp.mainWindow.contentView?.layer?.borderWidth = isShow ? kApp.mainWindow.currentWindowBorderWidth : 0.5
    }
}
extension ViewController : ScreenCaptureDelegate {
    func screenStateDidChange(state : RecordState, error : Error?, path : URL?) {
        guard let path = path else {
            return
        }
        StatusControlManager.share.state = state
        NSWorkspace.shared.activateFileViewerSelecting([path])
    }
    
    
}
