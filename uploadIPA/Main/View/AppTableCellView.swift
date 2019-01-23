//
//  AppTableCellView.swift
//  IPADownload
//
//  Created by Jason on 2018/10/24.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa
import SDWebImage

class AppTableCellView: NSTableCellView {
    
    @IBOutlet weak var iconView: NSImageView!
    
    @IBOutlet weak var nameLbl: NSTextField!
    
    @IBOutlet weak var bundleIDLbl: NSTextField!
    
    
    func config(_ model:AnyObject,_ type:UploadType) {
        
        iconView.wantsLayer = true
        
        iconView.layer?.cornerRadius = 4.0

        switch type {
        case .pgy:
            
            guard let model = model as? PgyApp else {
                return
            }
            
            nameLbl.stringValue = model.buildName ?? ""
            
            bundleIDLbl.stringValue = model.buildIdentifier ?? ""
            
            iconView.sd_setImage(with: model.iconURL)
            
        case .fir:
            
            guard let model = model as? FirApp else {
                return
            }
            
            nameLbl.stringValue = model.name ?? ""
            
            bundleIDLbl.stringValue = model.bundleID ?? ""
            
            iconView.sd_setImage(with: model.iconURL)
            
        }
        
    }

    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
