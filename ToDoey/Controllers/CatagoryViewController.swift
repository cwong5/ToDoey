//
//  CatagoryViewController.swift
//  ToDoey
//
//  Created by Chester Wong on 2018-08-13.
//  Copyright © 2018 CWC. All rights reserved.
//

import UIKit
import CoreData


class CatagoryViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    

    }

    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // Add action here
//            print(textField.text)
            
            
            let tempCategory = Category(context: self.context)
            tempCategory.name = textField.text!
            self.categoryArray.append(tempCategory)
            self.saveCategory()
            
            
            
        }
        alert.addTextField { (alertTextdField) in
            alertTextdField.placeholder = "Create new item"
            textField = alertTextdField
            
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
     //MARK: TableView Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListVIewController
        if let indexPath = tableView.indexPathForSelectedRow {
          destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
        
        
    }
    
    
    
    
    //MARK:  Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            context.delete(categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
            saveCategory()
        }
    }
    
    

    
    //MARK: Add New Categories
    
 
    
    
    //MARK: TableView Delegate Methods
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            
            print (error)
        }
        
        tableView.reloadData()
        
        
    }
    
    
    
    func loadCategory(with request:NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            
            categoryArray = try context.fetch(request)
            
        } catch {
            
            print (error)
            
        }
        tableView.reloadData()
    }
    
    
    
}
