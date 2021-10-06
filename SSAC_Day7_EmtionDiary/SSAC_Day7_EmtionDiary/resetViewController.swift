//
//  resetViewController.swift
//  SSAC_Day7_EmtionDiary
//
//  Created by 최혜린 on 2021/10/06.
//

import UIKit

class resetViewController: UIViewController {
    
    let DidDismissResetViewController: Notification.Name = Notification.Name("DidDismissResetViewController")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: self.DidDismissResetViewController, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
}
