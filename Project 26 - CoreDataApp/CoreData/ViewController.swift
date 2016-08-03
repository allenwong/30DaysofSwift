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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ViewController.addItem))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContex = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListEntity")
        do {
            
            let results = try managedContex.fetch(fetchRequest)
            listItems = results 
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
        
        let alertController = UIAlertController(title: "New Resolution", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField {
                
                self.saveItem(field.text!)
                self.tableView.reloadData()
                
            }
            
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addTextField (configurationHandler: {
            (textField) in
            
            textField.placeholder = "Type smothing..."
            
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func saveItem(_ itemToSave: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContex = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in: managedContex)
        let item = NSManagedObject(entity: entity!, insertInto: managedContex)
        
        item.setValue(itemToSave, forKey: "item")
        
        do {
            
            try managedContex.save()
            listItems.append(item)
            
        } catch {
            
            print("error")
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        
        let item = listItems[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = item.value(forKey: "item") as? String
        cell.textLabel?.font = UIFont(name: "", size: 25)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
           
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContex = appDelegate.managedObjectContext
            
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
            managedContex.delete(self.listItems[(indexPath as NSIndexPath).row])
            do {
                try managedContex.save()
                self.listItems.remove(at: (indexPath as NSIndexPath).row)
                self.tableView.reloadData()
            } catch {
                print("error: delete ")
            }
        }
        
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    


}

