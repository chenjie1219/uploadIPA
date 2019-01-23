//
//  NSImage+QRCode.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

extension NSImage{
    
    class func generateQRCode(_ text: String,_ width:CGFloat,_ fillImage:NSImage?=nil) -> NSImage? {
        
        //2.给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            //获取生成的二维码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            let scale = width/outPutImage.extent.width
            
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                
                let rep = NSCIImageRep(ciImage: output)
                
                let QRCodeImage = NSImage(size: rep.size)
                
                QRCodeImage.addRepresentation(rep)
                
                guard let fillImage = fillImage else {
                    return QRCodeImage
                }
                
                let fillRect = CGRect(x: (width - width/4)/2, y: (width - width/4)/2, width: width/4, height: width/4)
                
                QRCodeImage.lockFocus()
                
                fillImage.draw(in: fillRect)
                
                QRCodeImage.unlockFocus()
                
                return QRCodeImage
                
            }
            
        }
        
        return nil
        
    }
    
    
}
