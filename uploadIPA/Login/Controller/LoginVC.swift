//
//  LoginVC.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/29.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class LoginVC: NSViewController {

    @IBOutlet weak var logoView: NSImageView!
    
    @IBOutlet weak var tokenFld: NSTextField!
    
    lazy var isShow = false
    
    lazy var keyBtnTitle = "获取Key"
    
    lazy var uploadType = UploadType.pgy
    
    lazy var settingVC:LoginSettingVC = {
        
       let vc = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "login") as! LoginSettingVC
        
        vc.uploadType = uploadType
        
        return vc
        
    }()
    
    lazy var subWindow:NSWindow = {
        
        let window = NSWindow(contentRect: CGRect(x: view.window?.frame.origin.x ?? 0, y: (view.window?.frame.origin.y ?? 0) - 76, width: view.window?.frame.width ?? 0, height: 76), styleMask: .titled, backing: .buffered, defer: true)
        
        window.contentViewController = settingVC
        
        window.backgroundColor = NSColor(deviceRed: 0.93, green: 0.94, blue: 0.95, alpha: 1)
        
        return window
        
    }()
    
    
}



// MARK: - Click
extension LoginVC{
    
    @IBAction func switchClick(_ sender: NSPopUpButton) {
        
        if sender.selectedTag() == 0 {
            logoView.image = #imageLiteral(resourceName: "pgy")
            uploadType = .pgy
            tokenFld.placeholderString = "请输入API  Key"
            keyBtnTitle = "获取Key"
            if isShow{
                settingVC.keyBtn.title = "获取Key"
            }
        }else{
            logoView.image = #imageLiteral(resourceName: "airplane")
            uploadType = .fir
            tokenFld.placeholderString = "请输入API  Token"
            keyBtnTitle = "获取Token"
            if isShow{
                settingVC.keyBtn.title = "获取Token"
            }
        }
        
        settingVC.uploadType = uploadType
        
    }
    
    
    
    @IBAction func okClick(_ sender: Any) {
        
        login()
    }
    
    
    
    @IBAction func showOrHideSubWindow(_ sender: NSButton) {
        
        isShow = !isShow
        
        if isShow {
            
            view.window?.addChildWindow(subWindow, ordered: .below)
            
            subWindow.makeKeyAndOrderFront(nil)
            
            settingVC.keyBtn.title = keyBtnTitle
            
        }else{
            
            subWindow.orderOut(nil)
            
        }
        
    }
    
}



// MARK: - NSTextFieldDelegate
extension LoginVC:NSTextFieldDelegate{
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(insertNewline(_:)) {
            login()
            return true
        }
        return false
    }
    
    
}



// MARK: - CustomMethod
extension LoginVC{
    
    func login() {
        
        switch uploadType {
            
        case .pgy:
            
            let vm = PgyAppVM()
            
            vm.getApps(apiKey: tokenFld.stringValue) {
                
                self.showMainWindow(vm.pgyApps as [AnyObject])
            }
            
        case .fir:
            
            let vm = FirAppVM()
            
            vm.getApps(apiToken: tokenFld.stringValue) {
                
                self.showMainWindow(vm.firApps as [AnyObject])
                
            }
            
        }
        
    }
    
    
    func showMainWindow(_ apps:[AnyObject]) {
        
        let mainWindowController = NSStoryboard(name: "MainUI", bundle: nil).instantiateInitialController() as? LoginWindow
        
        let spitVC = mainWindowController?.contentViewController as? NSSplitViewController
        
        let leftVC = spitVC?.splitViewItems.first?.viewController as? LeftVC
        
        let rightVC = spitVC?.splitViewItems.last?.viewController as? RightVC
        
        rightVC?.uploadType = self.uploadType
        
        if apps.count == 0 {
            
            rightVC?.appInfoBox.isHidden = true
            
        }
        
        leftVC?.apps = apps
        
        leftVC?.uploadType = self.uploadType
        
        mainWindowController?.window?.makeKeyAndOrderFront(nil)
        
        view.window?.close()
        
    }
    
    
}
