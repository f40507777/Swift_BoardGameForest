//
//  ViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
    var items: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hackLogin()
        ref = Database.database().reference()
        print(ItemManager.getItems())


    }
    
    @IBAction func clickSend(_ sender: Any) {
        createItem()
    }
    
    func createItem() {
        self.ref.child("orders").child(randomOrderID()).setValue(["item": itemNameTextField.text! ,
                                                                  "cost": costTextField.text!])
    }
    
    func randomOrderID() -> String {
        return UUID().uuidString
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: itemNameTextField.text!, password: costTextField.text!) { (user, error) in
            
            if error == nil {
                self.showAlert(title: "success", content: "You have successfully signed up")
            } else {
                self.showAlert(title: "Error", content: (error?.localizedDescription)!)
            }
            
            
        }
    }
    
    func hackLogin (){
        Auth.auth().signIn(withEmail: "f40507777@gmail.com", password: "123456") { (user, error) in
            
            if error == nil {
                self.showAlert(title: "success", content: "login success!!")
            } else {
                self.showAlert(title: "error", content: "login failed!!")
                
            }
        }
    }
    
    func showAlert(title: String, content: String) {
        let alertController = UIAlertController(title: title,
                                                message: content,
                                                preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}


