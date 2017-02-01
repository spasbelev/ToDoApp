//
//  StartScreenViewController.swift
//  ToDoApp
//
//  Created by Student on 1/31/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit



class startScreenViewController: UIViewController
{
    @IBOutlet var imageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let delayTime = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: delayTime)
        {
            self.performSegue(withIdentifier: "loadingFinished", sender: self)
        }
       
    }
    
}
