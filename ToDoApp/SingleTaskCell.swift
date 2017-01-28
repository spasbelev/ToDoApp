//
//  SingleTaskCell.swift
//  ToDoApp
//
//  Created by Student on 1/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit



class SingleTaskCell: UITableViewCell
{
    
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
