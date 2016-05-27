//
//  File View.swift
//  BASIC Compiler
//
//  Created by Hanniel Malonzo on 5/25/16.
//  Copyright © 2016 Hanniel C. Malonzo. All rights reserved.
//

import Foundation
import UIKit

class SaveFileListView: UITableView {
    
    var Programs : [SaveFile]
    var viewInstance = ViewController()
    
    required init?(coder aDecoder: NSCoder) {
        
        Programs = [SaveFile]()
        
        let row0item = SaveFile()
        row0item.name = "Program 1"
        row0item.savedText = ""
        row0item.date = ""
        Programs.append(row0item)
        
        super.init(coder: aDecoder)
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        return Programs.count
    }
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = self.dequeueReusableCellWithIdentifier("SaveFile", forIndexPath: indexPath)
        let item = Programs[indexPath.row]
        
        configureTextForCell(cell, withSaveFile: item)
        return cell
    }
    
    func commitEditingStyle (editingStyle:UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath) {
        
        Programs.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        self.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func configureTextForCell(cell: UITableViewCell, withSaveFile item: SaveFile) {
        let label = cell.viewWithTag(1000) as! UILabel
        let label2 = cell.viewWithTag(500) as! UILabel
        label.text = item.name
        label2.text = "Last edited \(item.date)"
        print(label.text)
    }
    
    @IBAction func tapToAdd(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add SaveFile", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler{(textField) -> Void in
            textField.placeholder = "Add Save File Name Here"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let add = UIAlertAction(title: "Add", style: .Default){(action) -> Void in
            let SaveFileTextField = alert.textFields![0] as UITextField!
            let nextRow = SaveFile()
            nextRow.name = SaveFileTextField.text!
            self.Programs.append(nextRow)
        }
        alert.addAction(cancel)
        alert.addAction(add)
        viewInstance.presentViewController(alert, animated: true, completion: nil)
        
        //TODO: make it so added file becomes new in compiler
    }
    
    func canMoveRowAtIndexPath (indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func  moveRowAtIndexPath (sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let SaveFile = Programs[sourceIndexPath.row]
        Programs.removeAtIndex(sourceIndexPath.row)
        Programs.insert(SaveFile, atIndex: destinationIndexPath.row)
    }
}