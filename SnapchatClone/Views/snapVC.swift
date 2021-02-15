//
//  snapVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class snapVC: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    
    var selectedSnap : Snap?
    
    var selectedTime : Int?
        
        
        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let time = selectedTime {
            timeLbl.text = "Time Left: \(time)"
        }
        
        
        
    }
    

 

}
