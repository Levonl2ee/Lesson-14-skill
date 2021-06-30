//
//  TodoListRealmTableViewController.swift
//  Lesson 14
//
//  Created by Левон Амбарцумян on 18.06.2021.
//

import UIKit
import RealmSwift

class TaskObject: Object {
    
    @objc dynamic var title = ""
    
}

class TodoListRealmTableViewController: UITableViewController {

    let realm = try! Realm()
    var tasks: Results<TaskObject>!
    
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Новая задача", message: "Введите задачу", preferredStyle: .alert)
        
        let saveTask = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertController.textFields?.first
            
            guard  let text = tf?.text , !text.isEmpty else { return }
            
            let task = TaskObject()
            task.title = text
            
            try! self.realm.write {
                self.realm.add(task)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default) { _ in }
   
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = realm.objects(TaskObject.self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.count != 0 {
            return tasks.count

        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRealm", for: indexPath)
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
            let edingRows = tasks[indexPath.row]
            try! realm.write{
                self.realm.delete(edingRows)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
    }
}
