//
//  RightVC.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class RightVC: NSViewController {

    @IBOutlet weak var QRCodeView: NSImageView!
    
    @IBOutlet weak var typeLbl: NSTextField!
    
    @IBOutlet weak var versionLbl: NSTextField!
    
    @IBOutlet weak var buildLbl: NSTextField!
    
    @IBOutlet weak var urlLbl: NSTextField!
    
    @IBOutlet weak var createdAtLbl: NSTextField!
    
    @IBOutlet weak var appInfoBox: NSBox!
    
    lazy var uploadType = UploadType.pgy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: SelectionChange, object: nil, queue: nil) { (noti) in
        
            switch self.uploadType{
                
            case .pgy:
                
                
                guard let app = noti.object as? PgyApp else {
                    return
                }

                self.QRCodeView.image = NSImage.generateQRCode(app.shortURL ?? "", self.QRCodeView.frame.width)
                
                self.typeLbl.stringValue = app.type ?? ""
                
                self.versionLbl.stringValue = app.buildVersion ?? ""
                
                self.buildLbl.stringValue = app.buildVersionNo ?? ""
                
                self.urlLbl.stringValue = app.shortURL ?? ""
                
                self.createdAtLbl.stringValue = app.buildCreated ?? ""
                
                
            case .fir:
                
                guard let app = noti.object as? FirApp else {
                    return
                }
                
                self.QRCodeView.image = NSImage.generateQRCode(app.shortURL ?? "", self.QRCodeView.frame.width)
                
                self.typeLbl.stringValue = app.type ?? ""
                
                self.versionLbl.stringValue = app.masterRelease?.version ?? ""
                
                self.buildLbl.stringValue = app.masterRelease?.build ?? ""
                
                self.urlLbl.stringValue = app.shortURL ?? ""
                
                if let date = app.masterRelease?.createdAt {
                    let dateformatter = DateFormatter()
                    dateformatter.dateStyle = .short
                    dateformatter.timeStyle = .short
                    self.createdAtLbl.stringValue = dateformatter.string(from: date)
                }
                
            }
            
            
        }
        
    }
    
    
    
    @IBAction func linkBtnClick(_ sender: Any) {
        
        NSWorkspace.shared.open(URL(string: urlLbl.stringValue)!)
        
    }
    
    
}
