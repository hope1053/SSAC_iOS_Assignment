//
//  detailViewController.swift
//  SSAC_Day9_DrinkWater(UserDefaults)
//
//  Created by 최혜린 on 2021/10/11.
//

import UIKit
import TextFieldEffects

class detailViewController: UIViewController {

    @IBOutlet var currentLevelImage: UIImageView!
    @IBOutlet var nickNameField: HoshiTextField!
    @IBOutlet var heightField: HoshiTextField!
    @IBOutlet var weightField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIColor()
        setLabelText()
        setExtra()
    }
    
    func setUIColor() {
        view.backgroundColor = UIColor(red: 41/255, green: 151/255, blue: 110/255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        nickNameField.placeholderColor = .white
        nickNameField.borderActiveColor = .white
        nickNameField.borderInactiveColor = .white
        nickNameField.textColor = .white
        
        heightField.placeholderColor = .white
        heightField.borderActiveColor = .white
        heightField.borderInactiveColor = .white
        heightField.textColor = .white
        
        weightField.placeholderColor = .white
        weightField.borderActiveColor = .white
        weightField.borderInactiveColor = .white
        weightField.textColor = .white
    }
    
    func setLabelText() {
        self.navigationItem.rightBarButtonItem?.title = "저장"
        
        nickNameField.placeholder = "닉네임을 설정해주세요."
        heightField.placeholder = "키(cm)를 설정해주세요."
        weightField.placeholder = "몸무게(kg)를 설정해주세요."
        
        nickNameField.text = UserDefaults.standard.string(forKey: "name")
        heightField.text = "\(Int(UserDefaults.standard.double(forKey: "height")))"
        weightField.text = "\(Int(UserDefaults.standard.double(forKey: "weight")))"
    }
    
    func setExtra() {
        let drankWater = UserDefaults.standard.double(forKey: "drankWater")
        let totalWater = UserDefaults.standard.double(forKey: "totalWater")
        
        let currentPercentage = drankWater / totalWater * 100
        
        switch currentPercentage {
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
            currentLevelImage.image = UIImage(named: "1-9")
        }
        
        nickNameField.borderStyle = .none
        heightField.borderStyle = .none
        weightField.borderStyle = .none
        
        nickNameField.font = .systemFont(ofSize: 15, weight: .light)
        heightField.font = .systemFont(ofSize: 15, weight: .light)
        weightField.font = .systemFont(ofSize: 15, weight: .light)
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if nickNameField.text == "" {
            let alert = UIAlertController(title: "내용을 입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        if heightField.text == "" {
            let alert = UIAlertController(title: "내용을 입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let changedDoubleHeight = Double(heightField.text!) else {
            let alert = UIAlertController(title: "키와 몸무게 칸에는 숫자만  입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: { _ in
                self.heightField.text = ""
            })
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        if weightField.text == "" {
            let alert = UIAlertController(title: "내용을 입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let changedDoubleWeight = Double(weightField.text!) else {
            let alert = UIAlertController(title: "키와 몸무게 칸에는 숫자만  입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: { _ in
                self.heightField.text = ""
            })
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "저장됐습니다!", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "넵!", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
        UserDefaults.standard.set(nickNameField.text, forKey: "name")
        UserDefaults.standard.set(changedDoubleHeight, forKey: "height")
        UserDefaults.standard.set(changedDoubleWeight, forKey: "weight")
        UserDefaults.standard.set((changedDoubleWeight + changedDoubleHeight) * 10, forKey: "totalWater")
    }
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
