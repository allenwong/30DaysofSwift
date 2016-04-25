//
//  ViewController.swift
//  cd
//
//  Created by Allen on 16/2/3.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var listItems  = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addItem"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContex = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        
        do {
            
            let results = try managedContex.executeFetchRequest(fetchRequest)
            listItems = results as! [NSManagedObject]
            self.tableView.reloadData()
            
        } catch {
            
            print("error")
        }
        
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContex = appDelegate.managedObjectContext
//        
//        managedContex.deleteObject(listItems[indexPath.row])
//        listItems.removeAtIndex(indexPath.row)
//        
//        self.tableView.reloadData()
//        
//    }
    
    
    func addItem() {
        
        let alertController = UIAlertController(title: "New Resolution", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField {
                
                self.saveItem(field.text!)
                self.tableView.reloadData()
                
            }
            
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addTextFieldWithConfigurationHandler ({
            (textField) in
            
            textField.placeholder = "Type smothing..."
            
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    func saveItem(itemToSave: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContex = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("ListEntity", inManagedObjectContext: managedContex)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContex)
        
        item.setValue(itemToSave, forKey: "item")
        
        do {
            
            try managedContex.save()
            listItems.append(item)
            
        } catch {
            
            print("error")
            
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        let item = listItems[indexPath.row]
        
        cell.textLabel?.text = item.valueForKey("item") as? String
        cell.textLabel?.font = UIFont(name: "", size: 25)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
           
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContex = appDelegate.managedObjectContext
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
            managedContex.deleteObject(self.listItems[indexPath.row])
            do {
                try managedContex.save()
                self.listItems.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
            } catch {
                print("error: delete ")
            }
        }
        
        delete.backgroundColor = UIColor.redColor()
        
        return [delete]
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    


}

