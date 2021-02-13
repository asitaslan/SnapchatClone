//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class UploadVC: UIViewController {

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadButton.layer.cornerRadius = 8.0
        uploadButton.clipsToBounds = true
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        
    }
    
}
