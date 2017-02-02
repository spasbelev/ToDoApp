//
//  TaskDescriptionView.swift
//  ToDoApp
//
//  Created by Student on 2/2/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class taskDescription: UIViewController{
    
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var taskDueDate: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskName: UILabel!
    let dateFormatter = DateFormatter()
    var taskNumber:Int!
    var darkPurple:UIColor = UIColor.init(hue: 0.7083, saturation: 0.19, brightness: 0.4, alpha: 1.0)
    var lightPurple:UIColor = UIColor.init(hue: 0.7083, saturation: 0.39, brightness: 0.87, alpha: 1.0)
    
    let realm = try! Realm()
    var listOfTasks: Results<TaskDataType>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = darkPurple
        taskDueDate.textColor = lightPurple
        taskDescription.textColor = lightPurple
        taskName.textColor = lightPurple
        listOfTasks = realm.objects(TaskDataType.self)
        navigation.barTintColor = darkPurple
        backButton.tintColor = lightPurple
        self.taskDescription.text = listOfTasks[taskNumber].taskDescriprion
        self.taskName.text = listOfTasks[taskNumber].taskName
        
        DateFormatter.dateFormat(fromTemplate: "EEEE, MMMMM dd, yyyy' at ' h:mm:a", options: 0, locale: nil)
        self.taskDueDate.text! = DateFormatter.localizedString(from: listOfTasks[taskNumber].endData, dateStyle: .full, timeStyle: .full)
    }

    @IBAction func backToMainView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
