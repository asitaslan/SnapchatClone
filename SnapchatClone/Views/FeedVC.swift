//
//  FeedVCViewController.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 13.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class FeedVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
   
    

    @IBOutlet weak var tableView: UITableView!
    
    let firestoreDatabase = Firestore.firestore()
    
    var snapArray = [Snap]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.\
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        getSnapsFromFirebase()
        getUserInfo()
        
        
    }
    
    
    func getSnapsFromFirebase(){
        
        
        firestoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "ERROR")
            }else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    
                                    if  let differance = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        
                                        if differance >= 24 {
                                            
                                            self.firestoreDatabase.collection("Snaps").document(documentId).delete { (error) in
                                                if error != nil {
                                                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                    
                                }
                            }
                        }
                        
                    }
                }
                
                
            }
        }
        
    }
    
    
    
    func getUserInfo(){
        
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                
                self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "ERROR")
                
                
            }else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                        if let username = document.get("userName") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.userName = username
                            
                            
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath) as! CellVC
        cell.usernameLbl.text = snapArray[indexPath.row].username
        
        
        return cell
       }
    
    
    
    
}
