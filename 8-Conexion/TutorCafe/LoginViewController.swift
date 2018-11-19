//
//  LoginViewController.swift
//  TutorCafe
//
//  Created by fernando rossetti on 01/25/17.
//  Copyright © 2016 fernando rossetti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userField: UITextField!
    
    let request: Request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logIn(sender: UIButton) {
        let username = self.userField.text
        let pass = self.passwordField.text
        
        guard pass != "" && username != "" else {
            let newAlert = Utils.sharedInstance.createAlert("Campos requeridos", message: "Intenta otra vez")
            presentViewController(newAlert, animated: true, completion: nil)
            return
        }
        activityIndicator.startAnimating()
        
        request.logIn(username!, password: pass!) { (success, comment) in
            dispatch_async(dispatch_get_main_queue(), { 
                self.activityIndicator.stopAnimating()
            })
            
            if success {
                self.performSegueWithIdentifier("sessionsSegue", sender: self)                
            } else {
                let newAlert = Utils.sharedInstance.createAlert("Error en login", message: comment)
                self.presentViewController(newAlert, animated: true, completion: nil)
            }
        }
    }
}
