# SSAC iOS 앱 개발자 데뷔 과정 Assignment 
✨ SSAC iOS 앱 개발자 데뷔과정 과제 및 미션 아카이빙

No. | 날짜 | 과제 | 주제 | TIL | 폴더 바로가기
------------ | ------------- | ------------- | ------------- | -------------  | -------------
1 | 2021.09.30 | Netflix Project Sign Up | Stack View, 논리연산 | | [Netflix SignUp](https://github.com/hope1053/SSAC_iOS_Assignment/tree/main/SSAC_Day4_SignUp)
2 | 2021.10.01 - 10.03 | LED Board | Auto Layout, Tap Recognizer, Function | [Day5 TIL](https://velog.io/@hope1053/SSACiOSDay-5-TIL) | [LED Board](https://github.com/hope1053/SSAC_iOS_Assignment/tree/main/SSAC_Day5_LEDBoard)

<br>

## 👩‍💻 세부사항
### 1. Netflix Project Sign Up
#### 1-1. Stack View  
Textfield 5개, Button 그리고 Label과 Switch가 들어있는 Horizontal Stack View를 Vertical Stack View 하나에 넣어서 구현  
이때 Horizontal Stack View의 Alignment르 Center로 설정하여 높이 변화가 생겨도 label과 switch가 같은 선상에 있을 수 있도록 설정  
#### 1-2. isHidden
Switch가 On/Off 됨에 따라 switch의 isOn값을 받아와서 닉네임, 위치, 추천 코드 textfield의 isHidden상태를 처리해줌  
이때 UI 컴포넌트들의 사이즈를 일정하게 유지하기 위하여 Stack View의 height를 IBOutlet 변수로 할당함  
추후 스위치가 On/Off 됨에 따라 높이를 적절하게 조절해주어서 Stack View 안의 컴포넌트들이 일정한 사이즈를 유지할 수 있도록 함  
<br>
<img src = "https://user-images.githubusercontent.com/22907483/135413960-985858af-9400-4d6e-829a-ff3614e368f9.gif" width="30%">
#### 1-3. ID, Password, Code 조건 체크
- ID, Password는 반드시 입력되어야함
- Password는 최소 6글자 작성해야함
- Code에는 숫자만 입력해야함  
이때 placeholder text 및 색상 변경은 아래의 코드를 사용했다.
```swift
ID.attributedPlaceholder = NSAttributedString(string: "ID를 입력해주세요", attributes: [.foregroundColor: UIColor.red])
```
<img src = "https://user-images.githubusercontent.com/22907483/135418793-c637a5ba-f2bf-401f-b851-078059f73d1d.PNG" width="30%"> <img src = "https://user-images.githubusercontent.com/22907483/135418769-5b463a52-4900-4e77-8095-a9dfbd4ec262.PNG" width="30%"> <img src = "https://user-images.githubusercontent.com/22907483/135418786-484412e7-da08-4612-818c-67970455a7b4.PNG" width="30%">
