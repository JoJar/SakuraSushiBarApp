//
//  MapViewController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 09/05/2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display at default coordinates
        let camera_default = GMSCameraPosition.camera(withLatitude: 51.53, longitude: -0.14, zoom: 0.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera_default)
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)
        
        // Creates a marker at different locations
        
        // Location one: Camden
        let camdenMarker = GMSMarker()
        camdenMarker.position = CLLocationCoordinate2D(latitude: 51.53, longitude: -0.14)
        camdenMarker.title = "Sakura Sushi Bar Camden"
        camdenMarker.snippet = "Opening Hours: \n Monday to Friday: 10:00 - 23:00 \n Saturday: 10:00 - 00:00 \n Sunday: 12:00 - 22:00"
        camdenMarker.map = mapView
        
        // Location one: Oxford Street
        let oxfordMarker = GMSMarker()
        oxfordMarker.position = CLLocationCoordinate2D(latitude: 51.51, longitude: -0.14492555471219715)
        oxfordMarker.title = "Sakura Sushi Bar Oxford Street"
        oxfordMarker.snippet = "Opening Hours: \n Monday to Friday: 10:00 - 23:00 \n Saturday: 10:00 - 00:00 \n Sunday: 12:00 - 22:00"
        
        oxfordMarker.map = mapView
        
  }
}
