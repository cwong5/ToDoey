//
//  ViewController.swift
//  ToDoey
//
//  Created by Chester Wong on 2018-08-11.
//  Copyright © 2018 CWC. All rights reserved.
//

import UIKit
import CoreData

class ToDoListVIewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    var selectedCategory :Category? {
        didSet {
            loadItems()
            
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            
            print (error)
        }
        
        tableView.reloadData()

        
    }
    
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
      
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        } else {
            request.predicate = categoryPredicate

        }
        
        
        do {
            
            itemArray = try context.fetch(request)
            
        } catch {
            
            print (error)
            
        }
        tableView.reloadData()
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)

        


//        loadItems()
        

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
        
        

        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
   
    }
    
    
    //MARK: Add Button Pressed
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add To Do Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // Add action here
            print(textField.text)
            
            
            let tempItem = Item(context: self.context)
            tempItem.title = textField.text!
            tempItem.done = false
            tempItem.parentCategory = self.selectedCategory
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
    
//    context.delete(itemArray[indexPath.row])
//    itemArray.remove(at: indexPath.row)
//    saveItems()
   

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
                context.delete(itemArray[indexPath.row])
                itemArray.remove(at: indexPath.row)
                saveItems()
        }
    }
    

    
    
}


//MARK: Search Bar Methods

extension ToDoListVIewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
       let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        loadItems(with: request, predicate: predicate)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        
        
        }
        
    }
    
    
    
    
}
