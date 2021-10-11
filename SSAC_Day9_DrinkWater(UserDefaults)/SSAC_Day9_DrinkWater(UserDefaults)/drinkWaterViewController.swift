//
//  ViewController.swift
//  SSAC_Day9_DrinkWater(UserDefaults)
//
//  Created by 최혜린 on 2021/10/10.
//

import UIKit

class drinkWaterViewController: UIViewController {
    
    @IBOutlet var defaultText: UILabel!
    @IBOutlet var drankWaterLabel: UILabel!
    @IBOutlet var successPercentageLabel: UILabel!
    @IBOutlet var ml: UILabel!
    
    @IBOutlet var recommendedCommentLabel: UILabel!
    @IBOutlet var drankWaterTextField: UITextField!
    
    @IBOutlet var currentLevelImage: UIImageView!
    @IBOutlet var addWaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUIColor()
        setLabelText()
        setExtra()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLabelText()
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    func setData() {
        if UserDefaults.standard.string(forKey: "name") == nil {
            UserDefaults.standard.set("익명", forKey: "name")
            UserDefaults.standard.set(160, forKey: "height")
            UserDefaults.standard.set(50, forKey: "weight")
            UserDefaults.standard.set((160 + 50) * 10, forKey: "totalWater")
            UserDefaults.standard.set(0, forKey: "drankWater")
        }
    }

    func setUIColor() {
        view.backgroundColor = UIColor(red: 41/255, green: 151/255, blue: 110/255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        defaultText.textColor = .white
        drankWaterLabel.textColor = .white
        successPercentageLabel.textColor = .white
        ml.textColor = .white
        drankWaterTextField.textColor = .white
        recommendedCommentLabel.textColor = .white
        
        addWaterButton.tintColor = .black
        addWaterButton.backgroundColor = .white
        
        if UserDefaults.standard.double(forKey: "drankWater") >= UserDefaults.standard.double(forKey: "totalWater") {
            drankWaterLabel.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)
        }
    }
    
    func setLabelText() {
        self.navigationItem.title = "물 마시기"
        
        let drankWater = UserDefaults.standard.double(forKey: "drankWater")
        let totalWater = UserDefaults.standard.double(forKey: "totalWater")
        let name = UserDefaults.standard.string(forKey: "name")
        
        ml.text = "ml"
        
        defaultText.text = """
        잘하셨어요!
        오늘 마신 양은
        """
        drankWaterLabel.text = "\(Int(drankWater))ml"
        successPercentageLabel.text = "목표의 \(Int(drankWater / totalWater * 100))%"
        recommendedCommentLabel.text = "\(name!)님의 하루 물 권장 섭취량은 \(totalWater / 1000)L 입니다."
        
        addWaterButton.setTitle("물 마시기", for: .normal)
    }
    
    func setExtra() {
        drankWaterTextField.textAlignment = .right
        
        defaultText.numberOfLines = 0
        
        drankWaterTextField.borderStyle = .none
        
        defaultText.font = .systemFont(ofSize: 20, weight: .light)
        drankWaterLabel.font = .systemFont(ofSize: 23, weight: .bold)
        successPercentageLabel.font = .systemFont(ofSize: 12, weight: .light)
        drankWaterTextField.font = .systemFont(ofSize: 20, weight: .regular)
        ml.font = .systemFont(ofSize: 20, weight: .regular)
        recommendedCommentLabel.font = .systemFont(ofSize: 12, weight: .light)
        
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
    }

    @IBAction func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정말 초기화하시겠어요?", message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "네!", style: .default, handler: {_ in
            UserDefaults.standard.set(0, forKey: "drankWater")
            self.setLabelText()
            self.setExtra()
            self.setUIColor()
        })
        let cancel = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addWaterButtonTapped(_ sender: UIButton) {
        let currentWater = UserDefaults.standard.double(forKey: "drankWater")

        guard let addedWater = drankWaterTextField.text else {
            let alert = UIAlertController(title: "숫자를 입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: { _ in
                self.drankWaterTextField.text = ""
            })
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let addedDoubleWater = Double(addedWater) else {
            let alert = UIAlertController(title: "숫자를 입력해주세요!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵!", style: .default, handler: { _ in
                self.drankWaterTextField.text = ""
            })
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        UserDefaults.standard.set(currentWater + addedDoubleWater, forKey: "drankWater")
        drankWaterTextField.text = ""
        setUIColor()
        setLabelText()
        setExtra()
    }
    
    func prepareForAnimation() {
        defaultText.alpha = 0
        drankWaterLabel.alpha = 0
        successPercentageLabel.alpha = 0
        currentLevelImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    func showAnimation() {
        UIView.animate(
            withDuration: 0.8,
                   delay: 0,
                   options: .allowUserInteraction,
                   animations: {
                       self.defaultText.alpha = 1
               },
                   completion: nil)
        
        UIView.animate(
            withDuration: 0.5,
                   delay: 0.8,
                   options: .allowUserInteraction,
                   animations: {
                       self.drankWaterLabel.alpha = 1
               },
                   completion: nil)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 1.3,
                   options: .allowUserInteraction,
                   animations: {
                       self.successPercentageLabel.alpha = 1
               },
                   completion: nil)
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.repeat, .allowUserInteraction, .autoreverse],
                   animations: {
                       self.currentLevelImage.transform = CGAffineTransform.identity
               },
                   completion: nil)
    }
}

