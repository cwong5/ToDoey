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
        // Do any additional setup after loading the view, typically from a nib.
    }


    let itemArray = ["First item", "Second item", "third item"]
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

