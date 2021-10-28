//
//  ViewController.swift
//  SSAC_Lottery
//
//  Created by 최혜린 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet var firstView: extensionView!
    @IBOutlet var secondView: extensionView!
    @IBOutlet var thirdView: extensionView!
    @IBOutlet var fourthView: extensionView!
    @IBOutlet var fifthView: extensionView!
    @IBOutlet var sixthView: extensionView!
    @IBOutlet var seventhView: extensionView!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthLabel: UILabel!
    @IBOutlet var fifthLabel: UILabel!
    @IBOutlet var sixthLabel: UILabel!
    @IBOutlet var seventhLabel: UILabel!

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var selectedRoundLabel: UILabel!
    @IBOutlet var selectRoundTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        selectRoundTextField.inputView = pickerView
        pickerView.selectRow(99, inComponent: 0, animated: true)
        
        getResult(986)
        updateView()
    }
    
    func getResult(_ round: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.selectRoundTextField.text = "\(round)"
                self.selectedRoundLabel.text = "\(round)회"
                self.dateLabel.text = "\(json["drwNoDate"]) 추첨"

                self.firstLabel.text = "\(json["drwtNo1"])"
                self.secondLabel.text = "\(json["drwtNo2"])"
                self.thirdLabel.text = "\(json["drwtNo3"])"
                self.fourthLabel.text = "\(json["drwtNo4"])"
                self.fifthLabel.text = "\(json["drwtNo5"])"
                self.sixthLabel.text = "\(json["drwtNo6"])"
                self.seventhLabel.text = "\(json["bnusNo"])"
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func updateView() {
        let BGcolor = [#colorLiteral(red: 1, green: 0.9088488817, blue: 0, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 1, green: 0.3991929293, blue: 0.3315500319, alpha: 1), #colorLiteral(red: 0, green: 0.7649724483, blue: 1, alpha: 1)]
        firstView.backgroundColor = BGcolor.randomElement()
        secondView.backgroundColor = BGcolor.randomElement()
        thirdView.backgroundColor = BGcolor.randomElement()
        fourthView.backgroundColor = BGcolor.randomElement()
        fifthView.backgroundColor = BGcolor.randomElement()
        sixthView.backgroundColor = BGcolor.randomElement()
        seventhView.backgroundColor = BGcolor.randomElement()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(887 + row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getResult(887 + row)
        selectRoundTextField.endEditing(true)
        updateView()
    }
}

