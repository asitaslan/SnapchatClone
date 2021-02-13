//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 11.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
class SignInVC: UIViewController {

    @IBOutlet weak var emailTxt: UIStackView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signInButton.layer.cornerRadius = 8.0
        signInButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 8.0
        signUpButton.clipsToBounds = true
        
    }

    @IBAction func signInClicked(_ sender: Any) {
    
        if emailText.text != "" && passwordTxt.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordTxt.text!) { (result, error) in
                if error != nil{
                     
                    
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                    
                }else{
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                    
                }
            }
            
            
        }else{
            
            self.makeAlert(titleInput: "ERROR", messageInput: "email/Password")
            
        }
    
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameTxt.text != "" && emailText.text != "" && passwordTxt.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordTxt.text!) { (auth, error) in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    
                    
                    let firestore = Firestore.firestore()
                    
                    let userDictionary = ["email": self.emailText.text!, "userName": self.usernameTxt.text!] as [String: Any]
                    
                    firestore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                        if error != nil {
                            
                        }
                        
                    }
                    
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
        }else{
            self.makeAlert(titleInput: "ERROR", messageInput: "userNmae/email/Password")
            
            
        }
        
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil)
    }
}

