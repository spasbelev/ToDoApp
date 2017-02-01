//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by Student on 1/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let realm = try! Realm()
    var todoListOfTasks: Results<TaskDataType> {
        get{
            return realm.objects(TaskDataType.self)
        }
    }
    var totalNumberOfTasks:Int = 0
    var selectedtasks = NSMutableArray()
    

    @IBOutlet weak var progressStatus: UIProgressView!
    var finishedTasks:Double = 0.0
    
    var remainingTasks:Int = 0
    var darkPurple:UIColor = UIColor.init(hue: 0.7083, saturation: 0.19, brightness: 0.4, alpha: 1.0)
    var lightPurple:UIColor = UIColor.init(hue: 0.7083, saturation: 0.39, brightness: 0.87, alpha: 1.0)
    
    
    @IBOutlet weak var calendarView: UIBarButtonItem!
    @IBOutlet weak var addTask: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addTask(_ sender: Any) {
        performSegue(withIdentifier: "addTask", sender: self)
    }
    

    @IBAction func showCalendar(_ sender: Any) {
        performSegue(withIdentifier: "showCalendar", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        progressStatus.trackTintColor = UIColor.red
        totalNumberOfTasks = tableView.numberOfRows(inSection: 0)
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        progressStatus.progress = Float(finishedTasks)


        tableView.sectionFooterHeight = 10
        tableView.sectionHeaderHeight = 5
        


        
        progressStatus.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
       // let backGroundImage = UIImageView(image: UIColor.magenta)
        self.view.backgroundColor = darkPurple
        self.tableView.backgroundColor = darkPurple
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = darkPurple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Finish") { [weak self] (action, indexPath) in
            // delete item at indexPath
            let itemToBeDeleted = self?.todoListOfTasks[indexPath.row]
            try! self?.realm.write {
                self?.realm.delete(itemToBeDeleted!)
            }
            self?.finishedTasks += 1.0
            print("Finised tasks \(self?.finishedTasks)")
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.async { [weak self] in
                self?.updateProgress()
            }
        }
        delete.backgroundColor = .green
        return [delete]
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
        }
    
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTask",for: indexPath) as! SingleTaskCell
        
        let row = indexPath.row
        cell.taskDescription.text = todoListOfTasks[row].taskName
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let row = indexPath.row
        print("Description")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension FirstViewController: UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func updateProgress()
    {
        self.totalNumberOfTasks += todoListOfTasks.count + 1
        print("Total number:\(self.totalNumberOfTasks), finished tasks: \(self.finishedTasks) \n")
        
        let finishedTaskPercentage:Float = (Float(self.totalNumberOfTasks) / Float(self.finishedTasks)) / 100
        print(finishedTaskPercentage)
        switch finishedTaskPercentage
        {
        case 0.1..<0.3:
            self.progressStatus.backgroundColor = .green
        case 0.4..<0.6:
            self.progressStatus.backgroundColor = .green
        case 0.7..<1.0:
            self.progressStatus.backgroundColor = .green
        default:
            self.progressStatus.backgroundColor = UIColor.brown
        }
        self.progressStatus.setProgress(finishedTaskPercentage, animated: true)
    }
}
