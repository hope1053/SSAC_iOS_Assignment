//
//  DatePickerViewController.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.date = Date().dayBefore
    }
}
