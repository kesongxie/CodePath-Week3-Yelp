//
//  MapViewController.swift
//  Yelp
//
//  Created by Xie Kesong on 1/14/17.
//  Copyright © 2017  Xie Kesong. All rights reserved.
//

import UIKit
import MapKit

fileprivate let annotationViewReuseIden = "AnnotationView"
fileprivate let showDetailSegueIden = "ShowDetail"


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let iden = segue.identifier, iden == showDetailSegueIden{
            if let detailVC = segue.destination as? DetailViewController{
                if let business = sender as? Business{
                    detailVC.business = business
                }
            }
        }
    }
    
}



// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewReuseIden)
        if annotationView == nil{
            annotationView = MKPinAnnotationView()
        }
        
        
        //configure left accessory view
        let businessFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let businessImageView = UIImageView(frame: businessFrame)
        businessImageView.backgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        if let bussiness = annotation as? Business{
            businessImageView.setImageWith(bussiness.imageURL!)
        }
        annotationView?.leftCalloutAccessoryView = businessImageView
        
        //configure right accessory view
        let arrowBtnFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let arrowBtn = UIButton(frame: arrowBtnFrame)
        arrowBtn.setImage( UIImage(named: "arrow-icon"), for: .normal)
        annotationView?.rightCalloutAccessoryView = arrowBtn
        
        annotationView?.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: showDetailSegueIden, sender: view.annotation)
    }
    
}


