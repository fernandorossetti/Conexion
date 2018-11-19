//
//  Request.swift
//  TutorCafe
//
//  Created by fernando rossetti on 01/25/17.
//  Copyright © 2016 fernando rossetti. All rights reserved.
//

import Foundation
import Alamofire


typealias CompletionHandlerLogin = (success: Bool, comment: String) -> ()
typealias CompletionHandlerGetList = (success: Bool, data: [Session]?, error: String?) -> ()

struct Request {
    private let urlInit = "https://learn.nextu.com"
    
    func logIn(username: String, password: String, completion: CompletionHandlerLogin) {
        let url = urlInit + "/login/token.php"
        let params = ["username": username, "password": password, "service": "tutorcafe_webservice"]
        
        request(.GET, url, parameters: params)
            .responseJSON { (response) in
                switch response.result {
                case .Success(let JSON):
                    let jsonDic = JSON as! [String : AnyObject]
                    if let error = jsonDic["error"] as? String {
                        completion(success: false, comment: error)
                    } else {
                        let token = jsonDic["token"] as! String
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setValue(token, forKey: "Token")
                        completion(success: true, comment: "passed")
                    }
                case .Failure(let error):
                    completion(success: false, comment: error.localizedDescription)
                }
        }
    }
    
    func getList(completion: CompletionHandlerGetList) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let url = urlInit + "/webservice/rest/server.php"
        let token = defaults.stringForKey("Token")!
        let params = ["wstoken": token, "wsfunction": "tutorcafe_retrieve_sessions", "moodlewsrestformat": "json"]

        request(.GET, url, parameters: params)
            .responseJSON { (response) in
                switch response.result {
                case .Success(let JSON):
                    if let jsonDic = JSON as? [String : AnyObject] {
                        if let error = jsonDic["message"] as? String {
                            completion(success: false, data: nil, error: error)
                        }
                    } else {
                        let data = JSON as! [[String: AnyObject]]
                        if data.isEmpty {
                            completion(success: false, data: nil, error: "No hay sesiones disponibles")
                        } else {
                            let sessions = data.map({ (session) -> Session in
                                let date = session["date"] as! String
                                let time = session["time"] as! String
                                let title = session["topic"] as! String
                                let category = session["categoryname"] as! String
                                let resume = session["description"] as! String
                                
                                return  Session(date: date, time: time, title: title, category: category, resume: resume)
                            })
                            completion(success: true, data: sessions, error: nil)
                        }
                    }
                case .Failure(let error):
                    completion(success: false, data: nil, error: error.localizedDescription)
                }
        }
    }
}



