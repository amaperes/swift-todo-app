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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Todos.plist")
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodos()
    }
    
    //MARK: - TableView Datasource Methods
    
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
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        saveTodos()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Todos
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoee Item", message: "", preferredStyle: .alert)
        
        let action  = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newTodo = Todo()
            newTodo.title = textField.text!
            self.todoArray.append(newTodo)
            self.saveTodos()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveTodos() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(todoArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding todo array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadTodos() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                todoArray = try decoder.decode([Todo].self, from: data)
            } catch {
                print("Error decoding todo array, \(error)")
            }
        }
    }
}

