//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase

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
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = uploadImage.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "EROOR")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            let fireStore = Firestore.firestore()
                            
                            fireStore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.userName).getDocuments { (snapshot, error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        
                                        for document in snapshot!.documents {
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                                
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDictonary = ["imageUrlArray" : imageUrlArray] as [String : Any]
                                                
                                                fireStore.collection("Snaps").document(documentId).setData(additionalDictonary, merge: true) { (error) in
                                                    if error == nil {
                                                        
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImage.image = UIImage(named: "selected")
                                                    }
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }else{
                                        
                                        
                                        let snapDictonary = ["imageUrlArray": [imageUrl!], "snapOwner" : UserSingleton.sharedUserInfo.userName, "date": FieldValue.serverTimestamp()] as [String: Any]
                                        fireStore.collection("Snaps").addDocument(data: snapDictonary) { (error) in
                                                if error != nil {
                                                        self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                                                }else{
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImage.image = UIImage(named: "selected")
                                                }
                                        }
                                        
                                        
                                    }
                                    
                                }
                            }
                            
                      
                        }
                    }
                }
            }
            
        }
        
        
        
    }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil)
    }
    
}
