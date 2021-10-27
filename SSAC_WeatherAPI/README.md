# Weather API Application
## ✔️ 2021.10.27 업데이트
🔘 Request Key가 노출되는 것을 방지하기 위하여 APIKey.swift 파일 생성 후 타입 프로퍼티에 Key를 할당해주었다.
```swift
class Constants {
    static let API_KEY_WEATHER = "MY_KEY"
}

```
🔘 추후 코드 확장성을 고려하여 API 관련 코드를 별개의 파일로 생성해주었다. WeatherAPIManager.swift 파일 생성 후 싱글톤 패턴 활용 및 네트워킹 관련 코드를 작성해주었다.
- 서버로부터 받아온 내용을 View에 적용하기 위해서 `@escaping 클로져`를 사용했다. 
- 먼저 typealias로 `(Int, JSON) -> ()`을 지정해주고 Status Code와 서버로부터 받아온 정보를 매개변수로 전달해줬다.
 
```swift
class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func getCurrentWeather(_ latitude: Double, _ longitude: Double, result: @escaping CompletionHandler) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.API_KEY_WEATHER)"
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                result(statusCode, json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
```