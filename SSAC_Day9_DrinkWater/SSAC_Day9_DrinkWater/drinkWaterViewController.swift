//
//  drinkWaterViewController.swift
//  SSAC_Day9_DrinkWater
//
//  Created by 최혜린 on 2021/10/08.
//

import UIKit

class drinkWaterViewController: UIViewController {

    @IBOutlet var resetBarButton: UIBarButtonItem!
    @IBOutlet var personalBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 41/255, green: 151/255, blue: 110/255, alpha: 1)
        resetBarButton.tintColor = UIColor.white
        personalBarButton.tintColor = UIColor.white
    }
}
