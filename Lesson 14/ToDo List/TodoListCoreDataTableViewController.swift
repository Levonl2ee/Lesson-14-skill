//
//  TodoListCoreDataTableViewController.swift
//  Lesson 14
//
//  Created by Левон Амбарцумян on 17.06.2021.
//

import UIKit
import CoreData

class TodoListCoreDataTableViewController: UITableViewController {

    
    var tasks: [Tasks] = []
    
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Новая задача", message: "Введите задачу", preferredStyle: .alert)
        
        let saveTask = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTask = tf?.text {
                self.saveTask(withTitle: newTask)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default) { _ in }
   
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func saveTask(withTitle title: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else {return}
        
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.insert(taskObject, at: 0)
        } catch let error as NSError {
            print(error)
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            
            tasks = try context.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = tasks[indexPath.row].title
        cell.textLabel?.text = task
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            
            if let tasks = try? context.fetch(fetchRequest) {
                
                let edingRow = tasks[indexPath.row]
                    
                    context.delete(edingRow)
                    
                
                
            }
            tasks.remove(at: indexPath.row)
            do {
                
                try context.save()
                
            } catch let error as NSError {
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
    }
    
}
