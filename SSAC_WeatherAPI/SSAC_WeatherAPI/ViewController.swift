//
//  ViewController.swift
//  SSAC_WEEK5_CLASS
//
//  Created by 최혜린 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet var currentLocationLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var currentWeatherImageView: UIImageView!
    @IBOutlet var currentWindLabel: UILabel!
    @IBOutlet var currentHumidityLabel: UILabel!
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var currentDateLabel: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        updateUI()
    }
    
    func updateUI() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분"
        currentDateLabel.text = formatter.string(from: date)
        
        currentWeatherImageView.layer.cornerRadius = 20
        currentWindLabel.layer.masksToBounds = true
        currentWindLabel.layer.cornerRadius = 10
        currentHumidityLabel.layer.masksToBounds = true
        currentHumidityLabel.layer.cornerRadius = 10
        currentTemperatureLabel.layer.masksToBounds = true
        currentTemperatureLabel.layer.cornerRadius = 10
        commentLabel.layer.masksToBounds = true
        commentLabel.layer.cornerRadius = 10
    }
    
    func getCurrentWeather(_ latitude: Double, _ longitude: Double) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.API_KEY_WEATHER)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.currentTemperatureLabel.text = "   지금은 \(Int(currentTemp))도예요"
                print("JSON: \(json)")
                
                let currentHumidity = json["main"]["humidity"].doubleValue
                self.currentHumidityLabel.text = "   \(Int(currentHumidity))%만큼 습해요"
                
                let currentWind = json["wind"]["speed"].doubleValue
                self.currentWindLabel.text = "   \(round(currentWind * 10) / 10)m/s의 바람이 불어요"
                
                let currentImage = json["weather"][0]["icon"]
                let url = URL(string: "https://openweathermap.org/img/wn/\(currentImage)@2x.png")
                self.currentWeatherImageView.kf.setImage(with: url)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        checkUserLocationServicesAuthorization()
    }
}

extension ViewController: CLLocationManagerDelegate {
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
            let alert = UIAlertController(title: "위치 설정 권한이 필요합니다", message: "설정에 위치 서비스를 켜주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
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
            print("authorized always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            getCurrentWeather(coordinate.latitude, coordinate.longitude)
            convertToAddress(coordinate)
            
            locationManager.startUpdatingLocation()
            locationManager.stopUpdatingLocation()
        } else {
            let alertController = UIAlertController(title: "위치를 찾을 수 없습니다.", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default, handler: nil)

            alertController.addAction(OK)
            present(alertController, animated: true, completion: nil)
            title = "위치를 찾을 수 없습니다."
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServicesAuthorization()
    }
    
    func convertToAddress(_ coordinate: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if error != nil { return }
            guard let currentAdd = placemarks?.first else {return}
            
            self.currentLocationLabel.text = "\(currentAdd.administrativeArea!), \(currentAdd.locality!)"
        }
    }
}

