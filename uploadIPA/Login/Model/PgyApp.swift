//
//  PgyAppModel.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation

struct PgyApp{
    
    var buildCreated : String?
    
    var buildIcon : String?
    
    var iconURL:URL?{
        if let buildIcon = buildIcon {
            return URL(string: "https://www.pgyer.com/image/view/app_icons/\(buildIcon)")
        }else{
            return nil
        }
    }
    
    var buildIdentifier : String?
    
    var buildName : String?
    
    var buildShortcutUrl : String?
    
    var shortURL:String?{
        if let buildShortcutUrl = buildShortcutUrl {
            return "https://www.pgyer.com/\(buildShortcutUrl)"
        }else{
            return nil
        }
    }
    
    
    var buildType : String?
    
    var type:String?{
        
        if let buildType = buildType {
            
            if buildType == "1"{
                return "iOS"
            }else if buildType == "2"{
                return "Android"
            }else {
                return nil
            }
            
        }else{
            return nil
        }
        
    }
    
    
    var buildVersion : String?
    
    var buildVersionNo : String?
    

    init(fromDictionary dictionary: [String:Any]){
      
        buildCreated = dictionary["buildCreated"] as? String
      
        buildIcon = dictionary["buildIcon"] as? String
        
        buildIdentifier = dictionary["buildIdentifier"] as? String
        
        buildName = dictionary["buildName"] as? String
      
        buildShortcutUrl = dictionary["buildShortcutUrl"] as? String
        
        buildType = dictionary["buildType"] as? String
       
        buildVersion = dictionary["buildVersion"] as? String
        
        buildVersionNo = dictionary["buildVersionNo"] as? String
       
    }
    
}
