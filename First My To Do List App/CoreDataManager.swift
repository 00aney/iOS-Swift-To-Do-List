//
//  CoreDataManager.swift
//  First My To Do List App
//
//  Created by 김태동 on 2017. 1. 11..
//  Copyright © 2017년 00aney. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static func getManagedObject() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getData(entityName:String, predicate:NSPredicate?=nil) -> [NSManagedObject] {
        var resultsManagedObject: [NSManagedObject] = []
        do {
            
            let managedObject = getManagedObject()
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            if(predicate != nil) {
                
                request.predicate = predicate
                
            }
            
            let result = try managedObject.fetch(request)
            resultsManagedObject = result as! [NSManagedObject]
            
        } catch {
            
            print("getData: there was an error retreving data")
        }
        
        return resultsManagedObject
    }
    
    static func save(todoItem:String, dueDate:NSDate, complete:Bool) {
        let managedObject = getManagedObject()
        let todo = NSEntityDescription.insertNewObject(forEntityName: "ToDos", into: managedObject) as! ToDos
        
        todo.complete = complete
        todo.dueDate = dueDate
        todo.todoItem = todoItem
        
        do {
            try managedObject.save()
        } catch {
            print("save: Error saving.")
        }
    }
    
    static func update(todoItem:ToDos) {
        let managedObject = getManagedObject()
        
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDos")
            request.predicate = NSPredicate(format: "todoItem=%@ and dueDate=%@", todoItem.todoItem!, todoItem.dueDate!)
            
            let results = try managedObject.fetch(request)
            let resultSet = results as! [ToDos]
            resultSet[0].complete = todoItem.complete
            
        } catch {
            print("update: Error fetching")
        }
        
        do {
            try managedObject.save()
        } catch {
            print("update: Error updating")
        }
    }
}
