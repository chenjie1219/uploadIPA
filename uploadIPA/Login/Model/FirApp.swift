//
//  FirAppModel.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation

struct FirApp {
    
    var name:String?
    
    var bundleID:String?
    
    var type:String?
    
    var iconURL:URL?
    
    var short: String?
    
    var shortURL: String? {
        if let short = short {
            return "http://fir.im/\(short)"
        }else{
            return nil
        }
    }
    
    var masterRelease:appRelease?
    

    
    init(fromDictionary dictionary: [String:Any]){

        name = dictionary["name"] as? String
        bundleID = dictionary["bundle_id"] as? String

        type = dictionary["type"] as? String
        
        if let iconURLString = dictionary["icon_url"] as? String {
            self.iconURL = URL(string: iconURLString)
        }
        short = dictionary["short"] as? String
        
        masterRelease = appRelease(fromDictionary: dictionary["master_release"] as! [String : Any])
    }
    
}


struct appRelease {
    
    var build: String?
    var version: String?
    var createdAt: Date?
    
      init(fromDictionary dictionary: [String:Any]) {
        build = dictionary["build"] as? String
        version = dictionary["version"] as? String
        createdAt = Date(timeIntervalSince1970: (dictionary["created_at"] as? Double ?? 0))
    }
}
