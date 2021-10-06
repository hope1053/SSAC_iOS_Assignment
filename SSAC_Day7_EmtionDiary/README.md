# Emtion Diary
## 1. Stack View
Label 두 개를 먼저 Vertical Stack View로 묶고 Button을 추가하여 한 번 더 Horizontal Stack View로 묶어서 구성해주었다.  
<img src="https://user-images.githubusercontent.com/22907483/136178994-2da959ec-c9ce-4c2d-a61e-598c00672e14.png" width=30%>
<img src="https://user-images.githubusercontent.com/22907483/136179011-7a78f757-13e7-46f4-9ac1-fb6bab343d60.png" width=30%>

## 2. Tag & Function
하나의 Function으로 모든 버튼들이 기능을 공유할 수 있도록 구현하기 위해 Tag를 활용하였다.
먼저 모든 Labele들의 Outlet name을 "Label" + 숫자 형식으로 연결시켜주었다. 그리고 각 버튼 별로 1~9 범위의 숫자로 순서대로 Tag를 설정해주었다.
"Label" + 숫자 형식을 가진 프로퍼티를 가져와서 현재 값을 파악하고 여기에 1을 더한 값을 UserDefaults를 이용하여 저장했다. 이때 key값은 Outlet name과 동일하게 적용하였다. 

아래와 같이 하나의 메서드를 구현하고 9개의 버튼에 연결해줌으로써 코드가 길어지지 않고 간단하게 구현할 수 있었다!
```swift
@IBAction func buttonTapped(_ sender: UIButton) {
        let labelName = "label" + String(sender.tag)
        if let myProperty = value(forKey: labelName) as? UILabel {
            let currentValue = Int(myProperty.text!) ?? 0
            UserDefaults.standard.set(currentValue + 1, forKey: labelName)
            myProperty.text = "\(currentValue + 1)"
        }
    }
```
## 3. Library
Reset 기능이 있으면 좋을 것 같아서 추가하고자 했는데 버튼을 어떻게 배치하면 좋을지 고민이 됐다.
오늘 배운 Library를 활용하면 좋을 것 같아서 [Side Menu](https://github.com/jonkykong/SideMenu) Library를 활용하여 탭에 버튼을 추가하였다.
이때 Side 바의 너비가 생각보다 너무 넓어서 수정하고자 했는데 SPM으로 설치한 라이브러리는 바로 수정이 불가능했다.
그래서 `git clone`으로 파일을 다운받은 다음에 프로그램 파일 안에 드래그 드랍을 통해 파일을 다시 넣어주고 해당 파일 안에서 코드를 수정하여 너비를 원하는 만큼만 보이도록 수정할 수 있었다.  
<img src="https://user-images.githubusercontent.com/22907483/136179398-12fa5270-571c-4755-a538-a8c661614d14.png" width=30%>
<img src="https://user-images.githubusercontent.com/22907483/136179211-d2e4bcf8-794a-4049-b9d6-7cc992ad3016.png" width=30%>

## 4. Notification Center(개념 정리 필요)
Wandoo! 개발할 때도 자주 유용하게 썼던 Notification Center를 사용하여 reset 기능을 구현했다.
버튼이 눌린다고 사이드 바 뷰에서 초기화를 해줄 수 있는게 아니기 때문에 여기서 버튼의 기능은 "버튼이 눌렸다!"고 main View Controller에게 알려주는 것이다.

소식을 보내주는 것 처럼 생각하면 되는데 먼저 `DidDismissResetViewController`라는 이름의 Notification.Name을 선언해주고 버튼이 눌린 경우, `DidDismissResetViewController`라는 이름의 noti를 날려준다.
그리고 라이브러리 리드미를 읽어보니 화면을 다시 닫는 것이 dismiss로 구현돼있다고 하여 그 부분은 쉽게 해결할 수 있었다.
```swift
let DidDismissResetViewController: Notification.Name = Notification.Name("DidDismissResetViewController")

@IBAction func resetButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: self.DidDismissResetViewController, object: nil)
        dismiss(animated: true, completion: nil)
    }
```
그리고 소식을 받는 뷰의 viewDidLoad 메서드 안에 아래의 코드를 작성해준다.
`DidDismissResetViewController`라는 이름의 noti를 받으면 `#selector(resetUserDefaults)`를 실행할 것 이다. 라는 내용이다.
```swift
NotificationCenter.default.addObserver(self, selector: #selector(resetUserDefaults), name: NSNotification.Name(rawValue: "DidDismissResetViewController"), object: nil)
```
이제 소식을 받으면 여기서 진짜 초기화를 시켜줘야한다.
```swift
@objc func resetUserDefaults(_ noti: Notification) {
        for index in 1...9 {
            let labelName = "label" + String(index)
            UserDefaults.standard.set(0, forKey: labelName)
        }
        updateUI()
    }
```
9개의 버튼이 있기 때문에 모든 UserDefaults에 저장된 값을 0으로 초기화시켜주고 한 번 더 UI를 업데이트해주면 초기화도 마무리된다.  
<img src="https://user-images.githubusercontent.com/22907483/136180370-a29450b5-40d0-412e-bb0b-19e37188159f.gif" width = 30%>
