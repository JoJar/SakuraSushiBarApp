////
////  MapViewController.swift
////  Sakura Sushi Bar App
////
////  Created by Josh Jarvis on 09/05/2022.
////
//
import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a map view with default coordinates
        let mapView = MKMapView(frame: self.view.frame)
        mapView.showsUserLocation = true
        self.view.addSubview(mapView)
        
        // Create an annotation for Camden
        let camdenAnnotation = MKPointAnnotation()
        camdenAnnotation.coordinate = CLLocationCoordinate2D(latitude: 51.53, longitude: -0.14)
        camdenAnnotation.title = "Sakura Sushi Bar Camden"
        camdenAnnotation.subtitle = "Opening Hours: \n Monday to Friday: 10:00 - 23:00 \n Saturday: 10:00 - 00:00 \n Sunday: 12:00 - 22:00"
        mapView.addAnnotation(camdenAnnotation)
        
        // Create an annotation for Oxford Street
        let oxfordAnnotation = MKPointAnnotation()
        oxfordAnnotation.coordinate = CLLocationCoordinate2D(latitude: 51.51, longitude: -0.14492555471219715)
        oxfordAnnotation.title = "Sakura Sushi Bar Oxford Street"
        oxfordAnnotation.subtitle = "Opening Hours: \n Monday to Friday: 10:00 - 23:00 \n Saturday: 10:00 - 00:00 \n Sunday: 12:00 - 22:00"
        mapView.addAnnotation(oxfordAnnotation)
        
        // Set initial region
        let initialRegion = MKCoordinateRegion(center: camdenAnnotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(initialRegion, animated: true)
    }
}
