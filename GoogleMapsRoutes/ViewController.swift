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
        
        googleRouteService.getRoute(from: "1wpQjG6z9Bp2o4q0vRahpuOzbTug&ll")
    }
}


// MARK: - GoogleRouteService Delegate.

extension ViewController: GoogleRouteServiceDelegate {
    
    func didRoute(data: Data) {
        let kmlParser = GMUKMLParser(data: data)
        kmlParser.parse()
        
        let renderer = GMUGeometryRenderer(map: mapView,
                                           geometries: kmlParser.placemarks,
                                           styles: kmlParser.styles)
        renderer.render()
    }
}

// MARK: - GMSMapView Delegate.

extension ViewController: GMSMapViewDelegate {
    
}
