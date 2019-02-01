//
//  WeatherVC.swift
//  Ownapp
//
//  Created by Владислав on 1/30/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WeatherVC: NavRootVC {
    
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var weatherView: WeatherView!
    @IBOutlet weak var weatherViewHeight: NSLayoutConstraint!
    
    // Constants
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    
    // Variables
    var showWeatherViewIsNeed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setMapGestureRecognizer()
        locationManager.delegate = self
        
        configureLocationServices()
    }
    
    func showWeatherView() {
        UIView.animate(withDuration: 0.5) {
            self.weatherViewHeight.constant = 200
            self.view.layoutIfNeeded()
        }
    }
    
    func hideWeatherView() {
        UIView.animate(withDuration: 0.5) {
            self.weatherViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func closeWeatherViewBtnPressed(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        hideWeatherView()
    }
    
    @IBAction func getUserLocationWeatherBtnPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            guard let userCoordinates = locationManager.location?.coordinate else { return }
            
            mapView.removeAnnotations(mapView.annotations)
            
            setWeatherParams(to: userCoordinates) { success in
                if success {
                    self.centerMapOnSelectedLocation(with: userCoordinates)
                }
            }
        }
    }
}

extension WeatherVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if showWeatherViewIsNeed {
            showWeatherView()
            
            showWeatherViewIsNeed = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.image = UIImage(named: "pin")
        pinAnnotation.centerOffset = CGPoint(x: 0, y: -pinAnnotation.image!.size.height / 2)
        
        return pinAnnotation
    }
    
    func centerMapOnSelectedLocation(with coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setMapGestureRecognizer() {
        let holdClick = UILongPressGestureRecognizer(target: self, action: #selector(choosePlaceOnMap(sender:)))
        holdClick.minimumPressDuration = 1
        mapView.addGestureRecognizer(holdClick)
    }
    
    func dropPin(to coordinates: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = DroppablePin(coordinate: coordinates, identifier: "droppablePin")
        mapView.addAnnotation(annotation)
    }
    
    func setWeatherParams(to coordinates: CLLocationCoordinate2D, completion: @escaping CompletionHandler) {
        DataService.instance.toFormWeatherParams(for: coordinates) { (success) in
            if success {
                let weatherParams = DataService.instance.weatherParams
                let weatherImage = UIImage(named: weatherParams["image"] as! String)
                
                self.weatherView.setupView(title: weatherParams["title"] as! String,
                                           description: weatherParams["description"] as! String,
                                           temperature: weatherParams["temperature"] as! Int,
                                           humidity: weatherParams["humidity"] as! Int,
                                           windSpeed: weatherParams["windSpeed"] as! Int,
                                           image: weatherImage!)
                self.showWeatherViewIsNeed = true
                completion(true)
            }
        }
    }
    
    @objc func choosePlaceOnMap(sender: UIGestureRecognizer) {
        guard sender.state == .began else { return }
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        mapView.removeAnnotations(mapView.annotations)
        
        setWeatherParams(to: touchCoordinate) { success in
            if success {
                self.dropPin(to: touchCoordinate)
                self.centerMapOnSelectedLocation(with: touchCoordinate)
            }
        }
    }
}

extension WeatherVC: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
