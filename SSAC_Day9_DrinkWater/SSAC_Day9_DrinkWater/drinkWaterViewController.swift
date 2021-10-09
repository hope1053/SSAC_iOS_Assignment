//
//  drinkWaterViewController.swift
//  SSAC_Day9_DrinkWater
//
//  Created by 최혜린 on 2021/10/08.
//

import UIKit

class drinkWaterViewController: UIViewController {

    @IBOutlet var currentLevelImage: UIImageView!
    @IBOutlet var waterLabel: UILabel!
    @IBOutlet var drankWater: UILabel!
    @IBOutlet var successPercentage: UILabel!
    @IBOutlet var suggestedAmount: UILabel!
    @IBOutlet var drinkButton: UIButton!
    @IBOutlet var ml: UILabel!
    @IBOutlet var waterAmount: UITextField!
    @IBOutlet var resetBarButton: UIBarButtonItem!
    
    let viewModel = dataViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.personInfo = viewModel.loadData()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.personInfo = viewModel.loadData()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 41/255, green: 151/255, blue: 110/255, alpha: 1)
        self.navigationItem.title = "물 마시기"
        
        self.navigationController?.navigationBar.tintColor = .white
        
        ml.textColor = UIColor.white
        ml.font = .systemFont(ofSize: 20, weight: .regular)
        
        waterAmount.textColor = UIColor.white
        waterAmount.borderStyle = .none
        waterAmount.textAlignment = .center
        waterAmount.font = .systemFont(ofSize: 20, weight: .regular)
        
        drinkButton.backgroundColor = UIColor.white
        drinkButton.setTitle("물 마시기", for: .normal)
        drinkButton.tintColor = UIColor.black
        
        suggestedAmount.textColor = UIColor.white
        suggestedAmount.textAlignment = .center
        suggestedAmount.font = .systemFont(ofSize: 12, weight: .light)
        
        waterLabel.textColor = UIColor.white
        waterLabel.numberOfLines = 0
        waterLabel.font = .systemFont(ofSize: 20, weight: .light)
        waterLabel.text = """
        잘하셨어요!
        오늘 마신 양은
        """
        
        drankWater.textColor = UIColor.white
        drankWater.font = .systemFont(ofSize: 23, weight: .bold)
        
        successPercentage.textColor = UIColor.white
        successPercentage.font = .systemFont(ofSize: 12, weight: .light)
        
        if let personInfo = viewModel.personInfo {
            let currentPercantage = Int(personInfo.currentDrankWater / personInfo.totalWater / 10)
            drankWater.text = "\(Int(personInfo.currentDrankWater))ml"
            successPercentage.text = "목표의 \(currentPercantage)%"
            suggestedAmount.text = "\(personInfo.name)님의 하루 물 권장 섭취량은 \(personInfo.totalWater)L 입니다."
            
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
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func drinkButtonTapped(_ sender: UIButton) {
        if let amountText = waterAmount.text{
            if let waterAmount = Double(amountText) {
                let currentWaterAdded = viewModel.personInfo!.currentDrankWater + waterAmount
                viewModel.update(person: viewModel.personInfo!, water: currentWaterAdded)
                viewModel.personInfo = viewModel.loadData()
                
                setupUI()
            }
        }
        waterAmount.text = ""
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정말 초기화 하시겠어요?", message: nil, preferredStyle: .alert)
        let OK = UIAlertAction(title: "네!", style: .default, handler: {_ in
            self.viewModel.reset(person: self.viewModel.personInfo!)
            self.viewModel.personInfo = self.viewModel.loadData()
            self.setupUI()
        })
        let NO = UIAlertAction(title: "아니오", style: .destructive, handler: nil)
        
        alert.addAction(OK)
        alert.addAction(NO)
        
        present(alert, animated: true, completion: nil)
    }
}
