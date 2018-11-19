//
//  Utils.swift
//  TutorCafe
//
//  Created by fernando rossetti on 01/25/17.
//  Copyright © 2016 fernando rossetti. All rights reserved.
//

import UIKit

struct Utils {
    static let sharedInstance = Utils()
    
    private init () {
        
    }
    
    func createAlert(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Aceptar", style: .Default, handler: nil)
        alert.addAction(action)
        return alert
    }
}