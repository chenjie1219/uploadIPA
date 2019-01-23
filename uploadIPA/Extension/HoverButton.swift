//
//  HoverButton.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/29.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class HoverButton: NSButton {
    
    @IBInspectable var hoverImage:NSImage?
    
    lazy var hover = false
    
    var defaultImage:NSImage?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let trackingArea = NSTrackingArea(rect: bounds, options: [.activeInKeyWindow,.mouseEnteredAndExited], owner: self, userInfo: nil)
        
        addTrackingArea(trackingArea)
        // Drawing code here.
    }
    
    override func mouseEntered(with event: NSEvent) {
        
        if !hover {
            defaultImage = image
        }
        
        hover = true
        
        updateImage()
        
    }
    
    override func mouseExited(with event: NSEvent) {
        
        hover = false
        
        updateImage()
        
    }
    
    
    
    
    func updateImage() {
        
        if hover {
            image = hoverImage
        }else{
            image = defaultImage
        }
        
    }
    
}
