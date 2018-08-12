//
//  ViewController.swift
//  ToDoey
//
//  Created by Chester Wong on 2018-08-11.
//  Copyright © 2018 CWC. All rights reserved.
//

import UIKit

class ToDoListVIewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()

    
    func saveItems() {
        
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        } catch {
            print(error)
            
            
        }
        
        
        
    }
    
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
        let decode = PropertyListDecoder()
            
            do {
                itemArray = try decode.decode([Item].self, from: data)

            } catch {
                print (error)
                
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)

        
//        let newItem = Item()
//        newItem.title = "New Mike"
//        itemArray.append(newItem)

        loadItems()
        
        

    }
    


    
    
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
        
        self.saveItems()
        
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
            
            //MARK: Save to DB here
            
            self.saveItems()
                
           
            
            
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

