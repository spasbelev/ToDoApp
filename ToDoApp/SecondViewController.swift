//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by Student on 1/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var dateSelector: UIDatePicker!
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    var darkPurple:UIColor = UIColor.init(hue: 0.7083, saturation: 0.19, brightness: 0.4, alpha: 1.0)
    var lightPurple:UIColor = UIColor.init(hue: 0.7083, saturation: 0.39, brightness: 0.87, alpha: 1.0)

    var myTableView:  FirstViewController?
    let newTask:TaskDataType = TaskDataType()
    let realm = try! Realm()
    
    
    @IBAction func backToMainView(_ sender: Any) {
        
        
        newTask.taskName = self.taskName.text!
        newTask.taskDescriprion = self.taskDescription.text!
        newTask.endData = self.dateSelector.date
        
        try! realm.write {
            realm.add(newTask)
        }
        addTaskToDict(newTask)
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = darkPurple
        taskName.textColor = lightPurple
        taskDescription.textColor = lightPurple
        dateSelector.setValue(lightPurple, forKey: "textColor")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTaskToDict(_ task: TaskDataType)
    {
        let notification = UNMutableNotificationContent()
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: task.endData)
        let triger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        notification.title = task.taskName
        notification.sound = UNNotificationSound.default()
        notification.body = task.taskName
        
        let identifier = "TaskNotification"
        let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: triger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if(error != nil)
            {
                print("Error setting notification! \(error)")
            }
        }
    }
}

