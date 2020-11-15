//
//  MapViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 9/21/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var closure: ((CGPoint) -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
            backButton.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let longTapGuesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(sender:)))
        mapView.addGestureRecognizer(longTapGuesture)
        }
    
    @objc func longTap(sender: UIGestureRecognizer) {
        if sender.state == .began {
            
            mapView.removeAnnotations(mapView.annotations)
            
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationOnMap
            
            mapView.addAnnotation(annotation)
            
            let point = CGPoint(x: locationOnMap.latitude.rounded(2), y: locationOnMap.longitude.rounded(2))
            closure?(point)
            
        }
      }
   
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    }

extension Double {
    func rounded(_ number: Int) -> Double {
        let divisor = pow(10.0, Double(number))
        return (self * divisor).rounded() / divisor
    }
}




    

    


