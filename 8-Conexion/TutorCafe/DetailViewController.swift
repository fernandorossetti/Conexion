//
//  DetailViewController.swift
//  TutorCafe
//
//  Created by fernando rossetti on 01/25/17.
//  Copyright © 2016 fernando rossetti. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var titleValue: String!
    var date: String!
    var time: String!
    var category: String!
    var descriptionValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = titleValue
        self.dateLabel.text = date
        self.timeLabel.text = time
        self.categoryLabel.text = category
        self.descriptionText.text = descriptionValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backToTable(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
