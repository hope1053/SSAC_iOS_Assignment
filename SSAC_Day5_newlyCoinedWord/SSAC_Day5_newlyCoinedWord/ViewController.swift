//
//  ViewController.swift
//  SSAC_Day5_newlyCoinedWord
//
//  Created by 최혜린 on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = wordViewModel()
    
    @IBOutlet var searchField: UITextField!
    
    @IBOutlet var searchResult: UILabel!
    
    @IBOutlet var firstTagButton: UIButton!
    @IBOutlet var secondTagButton: UIButton!
    @IBOutlet var thirdTagButton: UIButton!
    @IBOutlet var fourthTagButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        keyboardGoDown()
        let input = searchField.text
        // 텍스트가 없는 경우
        if input == "" {
            let alert = UIAlertController(title: "잠시만요!", message: "검색어를 입력해주세요.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "넵!", style: .default, handler: nil)
            
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
        } else {
            // 텍스트가 있지만 리스트에 없는 경우
            if viewModel.searchWord(word: input!) == "no result" {
                let alert = UIAlertController(title: "죄송해요", message: "결과를 찾을 수 없습니다.", preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "네ㅜㅜ", style: .default, handler: nil)
                
                alert.addAction(OKAction)
                searchField.text = ""
                present(alert, animated: true, completion: nil)
            } else {
                // 텍스트가 있고 답도 있는 경우
                searchResult.text = viewModel.searchWord(word: input!)
            }
        }
    }
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        keyboardGoDown()
    }
    
    func keyboardGoDown() {
        view.endEditing(true)
    }
    
}

