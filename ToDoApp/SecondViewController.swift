//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by Student on 1/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBAction func backToMainView(_ sender: Any) {
        performSegue(withIdentifier: "backToMainView", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

