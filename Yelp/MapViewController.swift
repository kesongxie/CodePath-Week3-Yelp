//
//  MapViewController.swift
//  Yelp
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

fileprivate let annotationViewReuseIden = "AnnotationView"

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var businesses: [Business]?{
        didSet{
            self.drawBusinessAnnotations()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func drawBusinessAnnotations(){
        DispatchQueue.main.async {
            if let businesses = self.businesses{
                for business in businesses{
                    self.mapView.addAnnotation(business)
                }
                self.mapView.showAnnotations(businesses, animated: true)
            }
        }
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



// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewReuseIden)
        if annotationView == nil{
            annotationView = MKPinAnnotationView()
        }
        
        let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let businessImageView = UIImageView(frame: frame)
        businessImageView.backgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        if let bussiness = annotation as? Business{
            businessImageView.setImageWith(bussiness.imageURL!)
        }
        annotationView?.leftCalloutAccessoryView = businessImageView
        annotationView?.canShowCallout = true
        
        return annotationView
    }
}


