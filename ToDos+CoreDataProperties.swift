//
//  ToDos+CoreDataProperties.swift
//  First My To Do List App
//
//  Created by 김태동 on 2017. 1. 11..
//  Copyright © 2017년 00aney. All rights reserved.
//

import Foundation
import CoreData


extension ToDos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDos> {
        return NSFetchRequest<ToDos>(entityName: "ToDos");
    }

    @NSManaged public var todoItem: String?
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var complete: Bool

}
