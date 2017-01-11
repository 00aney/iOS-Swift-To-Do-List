//
//  ViewController.swift
//  First My To Do List App
//
//  Created by 김태동 on 2017. 1. 10..
//  Copyright © 2017년 00aney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dueTodayTable: UITableView!
    @IBOutlet weak var fiveDayTable: UITableView!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var dueTodayCount: UILabel!
    @IBOutlet weak var dueFiveDaysCount: UILabel!
    
    var todoDueToday:[ToDos] = []
    var todos:[ToDos] = []
    var todoFiveDay:[ToDos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //88, 101, 167
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 88/255, green: 101/255, blue: 167/255, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        dueTodayTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        fiveDayTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        dueTodayTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    func refreshData() {
        todos = CoreDataManager.getData(entityName: "ToDos") as! [ToDos]
        todoDueToday = CoreDataManager.getData(entityName: "ToDos", predicate: NSPredicate(format: "dueDate<=%@", (NSDate()))) as! [ToDos]
        
        let dayComponent = NSDateComponents()
        dayComponent.day = 5
        let theCalendar = NSCalendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent as DateComponents, to: Date())
        
        todoFiveDay = CoreDataManager.getData(entityName: "ToDos", predicate: NSPredicate(format: "dueDate<%@", (nextDate)! as CVarArg)) as! [ToDos]
        
        dueTodayTable.reloadData()
        fiveDayTable.reloadData()
        mainTable.reloadData()
        
    }
    
    
    func formatDate(date:Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM/dd"
        
        return dateFormatter.string(from: date)
        
    }
    
    //MARK: tableview functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == dueTodayTable) {
            dueTodayCount.text = String(todoDueToday.count)
            return todoDueToday.count
        } else if (tableView == fiveDayTable) {
            dueFiveDaysCount.text = String(todoFiveDay.count)
            return todoFiveDay.count
        } else {
            
            return todos.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == dueTodayTable) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let todo = todoDueToday[indexPath.row]
            cell.textLabel!.text = String(format: "%@: %@", todo.todoItem!, formatDate(date: todo.dueDate! as Date))
            
            return cell
            
        } else if (tableView == fiveDayTable) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let todo = todoFiveDay[indexPath.row]
            cell.textLabel!.text = String(format: "%@: %@", todo.todoItem!, formatDate(date: todo.dueDate! as Date))
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            let todo = todos[indexPath.row]
            cell.TodoItem.text = String(format: "%@: %@", todo.todoItem!, formatDate(date: todo.dueDate! as Date))
            
            cell.checkBox.text = "◻️"
            if(todo.complete == true) {
                cell.checkBox.text = "✅"
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (tableView.isEqual(mainTable)) {
            let todo = todos[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            
            if (cell.checkBox.text == "✅") {
                cell.checkBox.text = "◻️"
                todo.complete = false
            } else {
                cell.checkBox.text = "✅"
                todo.complete = true
            }
            
            CoreDataManager.update(todoItem: todo)
        }
        
        return indexPath
    }
    
    


}

