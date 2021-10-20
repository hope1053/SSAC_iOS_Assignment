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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
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
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위치"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            locationManager.startUpdatingLocation()
            updateNavigationTitle(coordinate)
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
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
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
}
