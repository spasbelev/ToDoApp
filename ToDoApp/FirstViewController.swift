//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by Student on 1/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var numberOftasks = NSMutableArray()
    var selectedtasks = NSMutableArray()
    var finishedTasks:Int = 0
    var remainingTasks:Int = 0
    
    @IBOutlet weak var progressStatus: UIProgressView!
    
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        progressStatus.progress = 0.0
        updateProgress()
        numberOftasks.add(1)
        
        progressStatus.setProgress(progressStatus.progress, animated: false)
        progressStatus.transform = CGAffineTransform(scaleX: 1.0,y: -5.0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOftasks.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTask") as! SingleTaskCell
        
        //cell.taskDescription.text = getDescriptionAtIndexpath(cellIndexpath: indexPath)
        _ = numberOftasks.object(at: indexPath.row)
        cell.checkBox.addTarget(self, action: #selector(FirstViewController.buttonChecked(sender:)), for: .touchUpInside)
        cell.taskDescription.text = "Task description"
        
        if selectedtasks.contains(numberOftasks.object(at: indexPath.row))
        {
            cell.checkBox.setBackgroundImage(UIImage(named:"selected.png"), for: UIControlState.normal)
        }
        else{
            cell.checkBox.setBackgroundImage(UIImage(named:"unknown.png"), for: UIControlState.normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let row = indexPath.row
        print("Description")
    }
    
    func buttonChecked(sender: UIButton!){
        let finishedTask = sender.tag
        
        if selectedtasks.contains(numberOftasks.object(at: finishedTask))
        {
            if numberOftasks.count > 0{
            selectedtasks.remove(numberOftasks.object(at: finishedTask))
            finishedTasks += 1
                if remainingTasks > 0
                {
                    remainingTasks -= 1

                }
                else{
                
                }
            }
            else{
            
            }
        }
        else{
            print("No tasks")
        }
        
        tableView.reloadData()
    }
    
    func updateProgress()
    {
        let percentageFinishedTsks:Float  = (Float(numberOftasks.count) - Float(finishedTasks)) / 10
        switch percentageFinishedTsks
        {
        case 0.0..<0.3:
            progressStatus.progressTintColor = .red
        case 0.4..<0.6:
            progressStatus.progressTintColor = .yellow
        case 0.7..<1.0:
            progressStatus.progressTintColor = .green
        default:
            progressStatus.backgroundColor = .blue
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

