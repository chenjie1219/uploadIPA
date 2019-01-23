//
//  PgyAppVM.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class PgyAppVM: NSObject {
    
    let baseURL = "https://www.pgyer.com/apiv2/app/listMy"
    
    lazy var pgyApps = [PgyApp]()
    
    //获取APP列表
    func getApps(apiKey:String,completion:@escaping (()->())) {
        
        let params = ["_api_key":apiKey]
        
        HttpTool.shared.request(method: .post, URLString: baseURL, parameters: params) { (result) in
            
            guard let data = result["data"] as? [String:AnyObject] else{
                
                let alert = NSAlert()
                
                alert.informativeText = "请输入正确的API Key"
                
                alert.runModal()
                
                return
            }
            
            guard let list = data["list"] as? [[String:AnyObject]] else{
                
                self.pgyApps = []
                
                completion()
                
                return
            }
            
            self.pgyApps.removeAll()
            
            for item in list {
                
                let model = PgyApp.init(fromDictionary: item)
                
                self.pgyApps.append(model)
                
            }
            
            completion()
            
        }
        
        
    }
    
    
}
