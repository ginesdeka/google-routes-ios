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
            let camera = GMSCameraPosition.camera(withLatitude: 39.462903, longitude: -0.380321, zoom: 12)
            mapView.camera = camera
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
        //googleRouteService.getRoute(from: "1qaXkVYuBo-r0tk28f-u9VcF6wKM&hl")
        loadKMLFile()
    }
    
    // MARK: - Private.
    
    private func loadKMLFile() {
        let url = Bundle.main.url(forResource: "VALENCIA", withExtension: "kml")!
        let data = try! Data(contentsOf: url)
        
        renderKML(data: data)
    }
    
    private func renderKML(data: Data) {
        let kmlParser = GMUKMLParser(data: data)
        kmlParser.parse()
        
//        let geometry = kmlParser.placemarks.first!
//        let name = geometry as? GMUPlacemark
        
        for container in kmlParser.placemarks {
            if let placemark = container as? GMUPlacemark {
                for style in kmlParser.styles {
                    if let styleURL = placemark.styleUrl, style.styleID.contains(styleURL) {
                        placemark.style = style
                        break
                    }
                }
            }
        }
                
        let renderer = GMUGeometryRenderer(map: mapView,
                                           geometries: kmlParser.placemarks,
                                           styles: kmlParser.styles,
                                           styleMaps: kmlParser.styleMaps)
        renderer.render()
    }
}


// MARK: - GoogleRouteService Delegate.

extension ViewController: GoogleRouteServiceDelegate {
    
    func didRoute(data: Data) {
        renderKML(data: data)
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
        let name = marker.title
        let description = marker.snippet
        return nil
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        return nil
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        
    }
}
