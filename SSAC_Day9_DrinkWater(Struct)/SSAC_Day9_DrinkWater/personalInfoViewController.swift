//
//  personalInfoViewController.swift
//  SSAC_Day9_DrinkWater
//
//  Created by 최혜린 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class personalInfoViewController: UIViewController {
    
    let viewModel = dataViewModel()
    
    @IBOutlet var currentLevelImage: UIImageView!
    
    @IBOutlet var saveBarButton: UIBarButtonItem!
    
    @IBOutlet var nickName: HoshiTextField!
    @IBOutlet var height: HoshiTextField!
    @IBOutlet var weight: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.personInfo = viewModel.loadData()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 41/255, green: 151/255, blue: 110/255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        nickName.textColor = .white
        height.textColor = .white
        weight.textColor = .white
        
        nickName.borderInactiveColor = .white
        height.borderInactiveColor = .white
        weight.borderInactiveColor = .white
        
        nickName.borderActiveColor = .white
        height.borderActiveColor = .white
        weight.borderActiveColor = .white
        
        nickName.placeholderColor = .white
        height.placeholderColor = .white
        weight.placeholderColor = .white
        
        nickName.placeholder = "닉네임을 입력하세요"
        height.placeholder = "키를 입력하세요"
        weight.placeholder = "몸무게를 입력하세요"
        
        if let personalInfo = viewModel.personInfo {
            nickName.text = personalInfo.name
            height.text = "\(personalInfo.height)"
            weight.text = "\(personalInfo.weight)"
            
            let currentPercantage = Int(personalInfo.currentDrankWater / personalInfo.totalWater / 10)
            
            switch currentPercantage {
            case 0..<20:
                currentLevelImage.image = UIImage(named: "1-1")
            case 20..<30:
                currentLevelImage.image = UIImage(named: "1-2")
            case 30..<40:
                currentLevelImage.image = UIImage(named: "1-3")
            case 40..<50:
                currentLevelImage.image = UIImage(named: "1-4")
            case 50..<60:
                currentLevelImage.image = UIImage(named: "1-5")
            case 60..<70:
                currentLevelImage.image = UIImage(named: "1-6")
            case 70..<80:
                currentLevelImage.image = UIImage(named: "1-7")
            case 80..<90:
                currentLevelImage.image = UIImage(named: "1-8")
            case 90...100:
                currentLevelImage.image = UIImage(named: "1-9")
            default:
                currentLevelImage.image = UIImage(named: "1-1")
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.save(name: nickName.text!, height: Double(height.text!)!, weight: Double(weight.text!)!, person: viewModel.personInfo!)
        viewModel.personInfo = viewModel.loadData()
        
        let alert = UIAlertController(title: "저장됐습니다!", message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "넵!", style: .default)

        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
    }
    
}

// 이름, 키, 몸무게 default값 설정해놓기
// 숫자만 들어가야하는 곳에 숫자만 들어갔는지 확인하기
// 빈칸 있으면 alert 띄우기
// 빈칸 없으면 저장됐다고 alert 띄우기
// 하루에 마셔야하는 물 양 계산하기
