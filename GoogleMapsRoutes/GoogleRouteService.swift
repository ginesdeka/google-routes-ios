//
//  GoogleRouteService.swift
//  GoogleMapsRoutes
//
//  Created by Ginés Navarro Fernández on 31/01/2020.
//  Copyright © 2020 Dekalabs. All rights reserved.
//

import Foundation

protocol GoogleRouteServiceDelegate: class {
    
    func didRoute(data: Data)
}

final class GoogleRouteService {
    
    // MARK: - Properties.
    
    weak var delegate: GoogleRouteServiceDelegate?
    let session: URLSession
    private var urlComponents = URLComponents()
    
    // MARK: - Init.
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        urlComponents.scheme = "https"
        urlComponents.host = "google.com"
        urlComponents.path = "/maps/d/kml"
    }
    
    // MARK: - Public.
    
    func getRoute(from mid: String) {
        
        guard var urlString = urlComponents.url?.absoluteString else {
            assertionFailure("No valid google service")
            return
        }
        
        urlString += "?mid=\(mid)&forcekml=1"
        
        guard let url = URL(string: urlString) else {
            assertionFailure("No valid url")
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, _, errorTask in
            // Error.
            if let error = errorTask {
                assertionFailure("Error Task")
                return
            }
            
            // Get Data.
            guard let data = data else {
                assertionFailure("Error Task: No data")
                return
            }
            
            DispatchQueue.main.async {
                self?.delegate?.didRoute(data: data)
            }
        }
        task.resume()
    }
}
