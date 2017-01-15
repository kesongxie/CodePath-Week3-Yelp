//
//  DetailViewController.swift
//  Yelp
//
//  Created by Xie Kesong on 1/14/17.
//  Copyright © 2017  Xie Kesong. All rights reserved.

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bussinessImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var writeReviewBtn: UIButton!{
        didSet{
            self.writeReviewBtn.layer.cornerRadius = 4.0
        }
    }
    var business: Business!
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if business != nil{
            self.bussinessImageView.loadBusinessImage(business: self.business)
            self.nameLabel.text = self.business.name
            self.addressLabel.text = self.business.address
            self.categoryLabel.text = self.business.categories
            self.distanceLabel.text = self.business.distance
            self.reviewLabel.text = "\(self.business.reviewCount!.stringValue) " + (self.business.reviewCount!.intValue > 1 ? "Reviews" : "Review")
            self.ratingImageView.setImageWith(self.business.ratingImageURL!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
