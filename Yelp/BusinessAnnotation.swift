//
//  BusinessAnnotation.swift
//  Yelp
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import MapKit

extension Business: MKAnnotation{
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: self.location!.coordinate.latitude, longitude:  self.location!.coordinate.longitude)
    }
    
    var title: String?{
        return self.name
    }
    
    var subtitle: String?{
        return self.address
    }
    
}
