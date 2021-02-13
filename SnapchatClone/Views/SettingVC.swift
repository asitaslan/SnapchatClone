//
//  SettingVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase

class SettingVC: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        logOutButton.layer.cornerRadius = 8.0
        logOutButton.clipsToBounds = true
        
    }
    


    @IBAction func selecktedLogOut(_ sender: Any) {
        
        do {
            
            
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            
            
            
        }catch{
            
        }
        
        
    }
    
    
}
