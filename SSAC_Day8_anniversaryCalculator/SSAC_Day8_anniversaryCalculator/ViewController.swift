//
//  ViewController.swift
//  SSAC_Day8_anniversaryCalculator
//
//  Created by 최혜린 on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var hundredLabel: UILabel!
    @IBOutlet var twoHundredLabel: UILabel!
    @IBOutlet var threeHundredLabel: UILabel!
    @IBOutlet var fourHundredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        calculateDate(currentDate: datePicker.date)
    }
    
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        calculateDate(currentDate: sender.date)
    }
    
    // 날짜 계산해서 label 업데이트하는 함수
    func calculateDate(currentDate: Date) {
        let format = DateFormatter()
        format.dateFormat = "yyyy년\nM월 dd일" // 21/10/20
        
        hundredLabel.text = format.string(from: Date(timeInterval:  86400 * 100, since: currentDate))
        twoHundredLabel.text = format.string(from: Date(timeInterval:  86400 * 200, since: currentDate))
        threeHundredLabel.text = format.string(from: Date(timeInterval:  86400 * 300, since: currentDate))
        fourHundredLabel.text = format.string(from: Date(timeInterval:  86400 * 400, since: currentDate))
    }

}

