//
//  ViewController.swift
//  ToDoey
//
//  Created by Chester Wong on 2018-08-11.
//  Copyright © 2018 CWC. All rights reserved.
//

import UIKit

class ToDoListVIewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let newItem = Item()
        newItem.title = "New Mike"
        itemArray.append(newItem)
        
        
        

    }
    


    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark: .none
        
      
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let tempItem = itemArray[indexPath.row]
        
        tempItem.done = !tempItem.done
        
        tableView.reloadData()
        
   
    }
    
    
    //MARK: Add Button Pressed
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add To Do Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // Add action here
            print(textField.text)
            
            let tempItem = Item()
            tempItem.title = textField.text!
                self.itemArray.append(tempItem)
            
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextdField) in
            alertTextdField.placeholder = "Create new item"
            textField = alertTextdField

          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

