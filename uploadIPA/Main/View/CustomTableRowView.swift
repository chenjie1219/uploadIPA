//
//  BaseTableView.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class CustomTableRowView: NSTableRowView {

    override func drawSelection(in dirtyRect: NSRect) {
        
        super.drawSelection(in: dirtyRect)
        
        if selectionHighlightStyle != .none {
            
            let selectionRect = bounds
            
            NSColor.white.setStroke()    //设置边框颜色
            
            NSColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1).setFill()   //设置填充背景颜色
            
            let path = NSBezierPath(rect: selectionRect)
            
            path.fill()
            
            path.stroke()
            
        }
    }
    
    
    //点击cell呈现自定义图片的方法
//    override func drawSelection(in dirtyRect: NSRect) {
//
//        super.drawSelection(in: dirtyRect)
//
//        if selectionHighlightStyle != .none {
//
//            let image = NSImage(named: "选中")
//
//            let imageRep = image?.representations.first
//
//            let fromRect = NSRect(x: 0, y: 0, width: imageRep?.size.width ?? 0, height: imageRep?.size.height ?? 0)
//
//            imageRep?.draw(in: dirtyRect, from: fromRect, operation: .sourceOver, fraction: 1.0, respectFlipped: true, hints: nil)
//
//        }
//
//    }
    
    
}
