//
//  ImageViewExtension.swift
//  Flicks
//
//  Created by Xie Kesong on 1/14/17.
//  Copyright © 2017  Xie Kesong. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView{
    func loadBusinessImage(business: Business){
        if let url = business.imageURL{
            let urlRequest = URLRequest(url: url)
            self.setImageWith(urlRequest, placeholderImage: nil, success: { (request, response, image) in
                if(response == nil){
                    //from cache
                    self.image = image
                }else{
                    self.alpha = 0.0
                    self.image = image
                    UIView.animate(withDuration: 0.3, animations: {
                        self.alpha = 1.0
                    })
                }
            }, failure: {
                (request, response, error) in
                print(error.localizedDescription)
            })
        }
    }

}
