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

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
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
    }
    
    func getResult(_ round: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
        AF.request(url + "\(round)", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.selectRoundTextField.text = "\(round)"
                self.selectedRoundLabel.text = "\(round)회"
                self.dateLabel.text = "\(json["drwNoDate"]) 추첨"
                let result = "\(json["drwtNo1"]) \(json["drwtNo2"]) \(json["drwtNo3"]) \(json["drwtNo4"]) \(json["drwtNo5"]) \(json["drwtNo6"]) + \(json["bnusNo"])"
                self.resultLabel.text = result
            case .failure(let error):
                print(error)
            }
        }
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
    }
}

