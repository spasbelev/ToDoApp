//
//  TaskDataType.swift
//  ToDoApp
//
//  Created by Student on 1/30/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class TaskDataType: Object
{
    dynamic var taskDescriprion = ""
    dynamic var taskName = ""
    dynamic var endData = Date();
    dynamic var isOverDue: Bool
    {
        return (Date().compare(self.endData) == ComparisonResult.orderedDescending)
    }
   // dynamic var taskCount:[TaskDataType] = []
    

    func addTaskToDatabase()
    {
        let task = TaskDataType()
        task.taskName = "Do mothefuka"
        try! realm?.write {
            self.realm?.add(task)
        }
    }
    
    func getTasksFromDatabase() -> Results<TaskDataType>
    {
        return (realm?.objects(TaskDataType.self))!
    }
    
}



