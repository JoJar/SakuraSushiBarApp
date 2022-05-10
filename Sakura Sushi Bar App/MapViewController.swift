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
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 51.53, longitude: -0.14, zoom: 0.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker at different locations
        
        // Location one: Camden
        let camdenMarker = GMSMarker()
        camdenMarker.position = CLLocationCoordinate2D(latitude: 51.53, longitude: -0.14)
        camdenMarker.title = "Sakura Sushi Bar Camden"
        camdenMarker.snippet = "Camden"
        camdenMarker.map = mapView
        
        // Location one: Oxford Street
        let oxfordMarker = GMSMarker()
        oxfordMarker.position = CLLocationCoordinate2D(latitude: 51.51, longitude: -0.14492555471219715)
        oxfordMarker.title = "Sakura Sushi Bar Borough"
        oxfordMarker.snippet = "Borough"
        oxfordMarker.map = mapView
        
  }
}
