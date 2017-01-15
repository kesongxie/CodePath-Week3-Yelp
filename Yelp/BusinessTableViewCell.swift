//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Xie Kesong on 1/14/17.
//  Copyright © 2017  Xie Kesong. All rights reserved.
//

import UIKit



class BusinessTableViewCell: UITableViewCell {

    var business: Business!{
        didSet{
            self.bussinessImageView.loadBusinessImage(business: self.business)
            self.bussinessImageView.layer.cornerRadius = 4.0
            self.bussinessImageView.clipsToBounds = true
            self.nameLabel.text = self.business.name
            self.addressLabel.text = self.business.address
            self.categoryLabel.text = self.business.categories
            self.distanceLabel.text = self.business.distance
            self.reviewLabel.text = "\(self.business.reviewCount!.stringValue) " + (self.business.reviewCount!.intValue > 1 ? "Reviews" : "Review")
            self.ratingImageView.setImageWith(self.business.ratingImageURL!)
        }
    }
    
    @IBOutlet weak var bussinessImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var expensiveLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    

}
