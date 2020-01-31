//
//  ViewController.swift
//  GoogleMapsRoutes
//
//  Created by Ginés Navarro Fernández on 31/01/2020.
//  Copyright © 2020 Dekalabs. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

class ViewController: UIViewController {

    // MARK: - Outlets.
    
    @IBOutlet private weak var mapView: GMSMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    // MARK: - Properties.
    
    private lazy var googleRouteService: GoogleRouteService = {
        let service = GoogleRouteService()
        service.delegate = self
        return service
    }()
    
    // MARK: - Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //googleRouteService.getRoute(from: "1wpQjG6z9Bp2o4q0vRahpuOzbTug&ll")
        googleRouteService.getRoute(from: "1qaXkVYuBo-r0tk28f-u9VcF6wKM&hl")
    }
}


// MARK: - GoogleRouteService Delegate.

extension ViewController: GoogleRouteServiceDelegate {
    
    func didRoute(data: Data) {
        let kmlParser = GMUKMLParser(data: data)
        kmlParser.parse()
                
        let renderer = GMUGeometryRenderer(map: mapView,
                                           geometries: kmlParser.placemarks,
                                           styles: kmlParser.styles,
                                           styleMaps: kmlParser.styleMaps)
        renderer.render()
    }
}

// MARK: - GMSMapView Delegate.

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        
    }

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let name = marker.description
        let description = marker.snippet
        return nil
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        return nil
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        
    }
}
