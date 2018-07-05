//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chia Khai Fong on 11/6/18.
//  Copyright © 2018 Chia Khai Fong. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

            loadCategories()
        
            tableView.separatorStyle = .none

    }

    //MARK - TableView Datasource Methods (To display all categories inside)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
                
        cell.backgroundColor = categoryColour
        
        cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        
        }
        
        return cell
    }
    
    
    //MARK - Data Manipulation Methods (Save data and load data)
    
    func save(category: Category){

        do {
            try realm.write {
                realm.add(category)
            }
        }  catch {
            print("Error saving Category \(error)")
        }

        tableView.reloadData()

    }

    func loadCategories() {

        categories = realm.objects(Category.self)
    
        tableView.reloadData()

    }
    
    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting Category, \(error)")
            }
        }
    
    }
    

    //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once the user clicks Add Cateogry Button on our UIAlert
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }

}

