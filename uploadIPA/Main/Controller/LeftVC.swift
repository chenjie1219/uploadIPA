//
//  LeftVC.swift
//  uploadIPA
//
//  Created by Jason on 2018/10/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import Cocoa

class LeftVC: NSViewController {
    
    @IBOutlet weak var logoView: NSImageView!
    
    @IBOutlet weak var tableView: NSTableView!
    
    var uploadType = UploadType.pgy{
        didSet{
            switch uploadType {
            case .pgy:
                logoView.image = #imageLiteral(resourceName: "pgy")
            case .fir:
                logoView.image = #imageLiteral(resourceName: "airplane")
            }
        }
    }
    
    
    var apps = [AnyObject](){
        
        didSet{
            
            tableView.reloadData()
            
            tableView.selectRowIndexes([0], byExtendingSelection: false)
            
            postNotification()
            
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        
    }
    

}



// MARK: - NSTableViewDelegate,NSTableViewDataSource
extension LeftVC:NSTableViewDelegate,NSTableViewDataSource{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let app = apps[row]
        
        let identifier = tableColumn?.identifier
        
        let cellView = tableView.makeView(withIdentifier: identifier!, owner: self) as? AppTableCellView
        
        cellView?.config(app, uploadType)
        
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        
        var rowView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "rowView"), owner: self) as? CustomTableRowView
        
        if rowView == nil {
            
            rowView = CustomTableRowView()
            
            rowView?.identifier = NSUserInterfaceItemIdentifier(rawValue: "rowView")
            
        }
        
        return rowView
        
        
        
    }
    
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        postNotification()
        
    }
    
    
}




// MARK: - CustomMethod
extension LeftVC{
    
    func postNotification() {
        
        if tableView.selectedRow >= 0 {
            
            let app = apps[tableView.selectedRow]
            
            NotificationCenter.default.post(name: SelectionChange, object: app)
            
        }
        
    }
    
    
    func uploadFile(_ url:URL) {
        
        
        
        
    }
    
    
    
}




// MARK: - Click
extension LeftVC{
    
    @IBAction func uploadBtnClick(_ sender: Any) {
        
        let openPanel = NSOpenPanel()
        
        openPanel.allowsMultipleSelection = false
        
        openPanel.allowedFileTypes = ["ipa"]
        
        if openPanel.runModal() == NSApplication.ModalResponse.OK {
            
            guard let url = openPanel.url else{
                return
            }
            
            uploadFile(url)
            
        }
        
        
    }
    
}
