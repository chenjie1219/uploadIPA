//
//  LoginSettingVC.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/29.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class LoginSettingVC: NSViewController {
    
    @IBOutlet weak var keyBtn: NSButton!
    
    lazy var uploadType = UploadType.pgy

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func getTokenClick(_ sender: Any) {
        
        if uploadType == .pgy {
            NSWorkspace.shared.open(URL(string: "https://www.pgyer.com/account/api")!)
        }else{
        NSWorkspace.shared.open(URL(string: "https://fir.im/apps/apitoken")!)
        }
    }
    
}
