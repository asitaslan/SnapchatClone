//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadButton.layer.cornerRadius = 8.0
        uploadButton.clipsToBounds = true
        
        uploadImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choosePicture(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        
    }
    
}
