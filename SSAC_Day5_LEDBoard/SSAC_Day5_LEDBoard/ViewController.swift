//
//  ViewController.swift
//  SSAC_Day5_LEDBoard
//
//  Created by 최혜린 on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var boardView: UIView!
    @IBOutlet var writtenText: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendTextButton(_ sender: UIButton) {
        guard let boardText = writtenText.text else {return}
        resultLabel.text = boardText
    }
    
    @IBAction func changeColorButton(_ sender: UIButton) {
        let randomColorArray: [UIColor] = [.red, .yellow, .white, .green, .blue, .lightGray, .magenta, .orange, .purple]
        resultLabel.textColor = randomColorArray.randomElement()
    }
    
}

