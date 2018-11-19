//
//  Session.swift
//  TutorCafe
//
//  Created by vicente rodriguez on 12/30/16.
//  Copyright © 2016 vicente rodriguez. All rights reserved.
//

import UIKit


enum TypeImage: String {
    case Web = "Desarrollador Web"
    case Android = "Desarrollador Móvil (Android)"
    case Ios = "Desarrollador iOS"
    case Software = "Desarrollador de Software"
    case Marketing = " Desarrollador de Marketing"
}

struct Session {
    let date: String
    let time: String
    let title: String
    let category: String
    let resume: String

    init(date: String, time: String, title: String, category: String, resume: String) {
        self.date = date
        self.time = time
        self.title = title
        self.category = category
        self.resume = resume
    }
    
    func nameOfImage(name: String) -> String {
        let image = TypeImage(rawValue: name)!
        switch image {
        case .Web:
            return "web"
        case .Android:
            return "android"
        case .Ios:
            return "ios"
        case .Software:
            return "javascript"
        case .Marketing:
            return "marketing"
        }
    }
}