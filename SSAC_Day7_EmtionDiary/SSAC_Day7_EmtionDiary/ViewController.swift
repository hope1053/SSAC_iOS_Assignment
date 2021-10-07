//
//  ViewController.swift
//  SSAC_Day7_EmtionDiary
//
//  Created by 최혜린 on 2021/10/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label9: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(resetUserDefaults), name: NSNotification.Name(rawValue: "DidDismissResetViewController"), object: nil)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let labelName = "label" + String(sender.tag)
        if let myProperty = value(forKey: labelName) as? UILabel {
            let currentValue = Int(myProperty.text!) ?? 0
            UserDefaults.standard.set(currentValue + 1, forKey: labelName)
            myProperty.text = "\(currentValue + 1)"
        }
    }
    
    func updateUI() {
        for index in 1...9 {
            let labelName = "label" + String(index)
            if let myProperty = value(forKey: labelName) as? UILabel {
                myProperty.text = "\(UserDefaults.standard.integer(forKey: labelName) )"
            }
        }
    }
    
    @objc func resetUserDefaults(_ noti: Notification) {
        for index in 1...9 {
            let labelName = "label" + String(index)
            UserDefaults.standard.set(0, forKey: labelName)
        }
        updateUI()
    }
}
