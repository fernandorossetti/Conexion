//
//  ViewController.swift
//  TutorCafe
//
//  Created by fernando rossetti on 01/25/17.
//  Copyright © 2016 fernando rossetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    let request: Request = Request()
    var sessions = [Session]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getSessions()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getSessions() {
        self.activityIndicator.startAnimating()
        request.getList { (success, data, error) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.sessions.appendContentsOf(data!)
                    self.collectionView.reloadData()
                })
            } else {
                let newAlert = Utils.sharedInstance.createAlert("Error al obtener las sesiones", message: error)
                self.presentViewController(newAlert, animated: true, completion: nil)
            }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sessions.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("sessionCell", forIndexPath: indexPath) as! SessionCollectionViewCell
        let currentSession = sessions[indexPath.row]
        cell.titleLabel.text = currentSession.title
        cell.categoryLabel.text = currentSession.category
        cell.hourLabel.text = currentSession.time
        cell.dateLabel.text = currentSession.date
        cell.imageView.image = UIImage(named: currentSession.nameOfImage(currentSession.category))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let orientation = UIDevice.currentDevice().orientation

        var size: CGSize = CGSize(width: view.frame.width - 50, height: 250.0)
        
        if orientation.isPortrait {
            size = CGSize(width: view.frame.width - 50, height: 250.0)
        } else if orientation.isLandscape {
            size = CGSize(width: (view.frame.width - 50) / 2, height: 250.0)
        }
        return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let index = collectionView.indexPathsForSelectedItems()?.first
            let currentSession = sessions[index!.row]
            
            let vc = segue.destinationViewController as! DetailViewController
            vc.time = currentSession.time
            vc.category = currentSession.category
            vc.date = currentSession.date
            vc.time = currentSession.time
            vc.descriptionValue = currentSession.resume
            vc.titleValue = currentSession.title
        }
    }
    
    

}

