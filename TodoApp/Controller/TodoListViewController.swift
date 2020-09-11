//
//  ViewController.swift
//  TodoApp
//
//  Created by Antonela Madalina on 10/09/2020.
//  Copyright © 2020 AM Perescu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todoArray = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newTodo = Todo()
        newTodo.title = "Design iOS app"
        todoArray.append(newTodo)
        
        let newTodo2 = Todo()
        newTodo2.title = "Implement iOS app"
        todoArray.append(newTodo2)
        
        let newTodo3 = Todo()
        newTodo3.title = "Launch iOS app"
        todoArray.append(newTodo3)
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let todo = todoArray[indexPath.row]
        cell.textLabel?.text = todo.title
        
        if todo.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoee Item", message: "", preferredStyle: .alert)
        
        let action  = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newTodo = Todo()
            newTodo.title = textField.text!
            self.todoArray.append(newTodo)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

