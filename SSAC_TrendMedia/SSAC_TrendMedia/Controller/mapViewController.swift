//
//  mapViewController.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/20.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let theaterCoordinates = coordinateInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for theater in TheaterType.allCases {
            actionSheetController.addAction(UIAlertAction(title: theater.description, style: .default, handler: { _ in
                self.setTheaterAnnotations(theater.description)
            }))
        }
        let totalTheater = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.addAllAnnotations()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        actionSheetController.addAction(totalTheater)
        actionSheetController.addAction(cancel)
        present(actionSheetController, animated: true, completion: nil)
    }
}

extension mapViewController: CLLocationManagerDelegate {
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            let alertController = UIAlertController(title: "위치 권한을 허락해주세요", message: "설정에서 위치 서비스를 켜주세요ㅜㅜ!", preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alertController.addAction(OK)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            showFakeRegion()
            let alertController = UIAlertController(title: "위치 권한을 허락해주세요", message: "설정에서 위치 서비스를 켜주세요ㅜㅜ!", preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default) { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            let NO = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
            alertController.addAction(OK)
            alertController.addAction(NO)
            present(alertController, animated: true, completion: nil)
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            UserDefaults.standard.set([coordinate.latitude, coordinate.longitude], forKey: "coordinate")
            
            locationManager.startUpdatingLocation()
            updateNavigationTitle(coordinate)
            addAllAnnotations()
            locationManager.stopUpdatingLocation()
        } else {
            showFakeRegion()
            let alertController = UIAlertController(title: "위치를 찾을 수 없습니다.", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alertController.addAction(OK)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showFakeRegion()
        let alertController = UIAlertController(title: "위치를 찾을 수 없습니다.", message: nil, preferredStyle: .alert)
        let OK = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alertController.addAction(OK)
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServicesAuthorization()
    }
    
    func showFakeRegion() {
        let coordinate = CLLocationCoordinate2D(latitude: 37.5638155, longitude: 126.965426)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "서울 시청"
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func updateNavigationTitle(_ coordinate: CLLocationCoordinate2D) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        title = "위도: \(latitude), 경도: \(longitude)"
    }
    
    func setTheaterAnnotations(_ theaterType: String) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        addCurrentAnnotation()
        
        for location in theaterCoordinates.mapAnnotations {
            if location.type == theaterType {
                let theaterCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                let theaterAnnotation = MKPointAnnotation()
                theaterAnnotation.title = location.location
                theaterAnnotation.coordinate = theaterCoordinate
                
                mapView.addAnnotation(theaterAnnotation)
            }
        }
    }
    
    func addAllAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        addCurrentAnnotation()

        for location in theaterCoordinates.mapAnnotations {
            let theaterCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let theaterAnnotation = MKPointAnnotation()
            theaterAnnotation.title = location.location
            theaterAnnotation.coordinate = theaterCoordinate
            
            mapView.addAnnotation(theaterAnnotation)
        }
    }
    
    func addCurrentAnnotation() {
        let coordinate = UserDefaults.standard.object(forKey: "coordinate") as! [Double]
        let latitude = coordinate[0]
        let longitude = coordinate[1]
        
        let currentCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.title = "현재 위치"
        currentAnnotation.coordinate = currentCoordinate
        
        mapView.addAnnotation(currentAnnotation)
    }
}
