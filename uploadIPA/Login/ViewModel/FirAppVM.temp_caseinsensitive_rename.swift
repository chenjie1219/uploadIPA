//
//  firAppVM.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class FirAppVM: NSObject {
    
    let baseURL = "http://api.fir.im/apps"
    
    lazy var firApps = [FirAppModel]()
    
    //获取APP列表
    func getApps(apiToken:String,completion:@escaping (()->())) {
        
        let params = ["api_token":apiToken]
        
        HttpTool.shared.request(method: .get, URLString: baseURL, parameters: params) { (result) in
            
            guard let _ = result["apps_count"] as? NSInteger else{
                
                let alert = NSAlert()
                
                alert.informativeText = "请输入正确的API Token"
                
                alert.runModal()
                
                return
            }
            
            
            guard let items = result["items"] as? [[String:AnyObject]] else{
                
                self.firApps = []
                
                completion()
                
                return
            }
            
            self.firApps.removeAll()
            
            for item in items {
                
                let model = FirAppModel.init(fromDictionary: item)
                
                self.firApps.append(model)
                
            }
            
            completion()
            
        }
        
        
    }
    
    
}
