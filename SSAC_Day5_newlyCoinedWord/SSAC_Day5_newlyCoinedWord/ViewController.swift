//
//  ViewController.swift
//  SSAC_Day5_newlyCoinedWord
//
//  Created by 최혜린 on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = wordViewModel()
    
    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var searchResult: UILabel!
    
    @IBOutlet var firstTagButton: UIButton!
    @IBOutlet var secondTagButton: UIButton!
    @IBOutlet var thirdTagButton: UIButton!
    @IBOutlet var fourthTagButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonText()
        
        searchStackView.layer.borderWidth = 2
        searchStackView.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        updateButtonText()
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
                searchField.text = ""
                searchResult.text = "신조어를 찾을 수 없습니다 ㅜㅜ"
            } else {
                // 텍스트가 있고 답도 있는 경우
                searchResult.text = viewModel.searchWord(word: input!)
            }
        }
    }
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        searchButtonTapped(searchButton)
    }
    
    func updateButtonText() {
        let randomList = viewModel.getRandomWord()
        
        firstTagButton.setTitle(randomList[0], for: .normal)
        secondTagButton.setTitle(randomList[1], for: .normal)
        thirdTagButton.setTitle(randomList[2], for: .normal)
        fourthTagButton.setTitle(randomList[3], for: .normal)
    }
    
    @IBAction func tagButtonTapped(_ sender: UIButton) {
        searchField.text = sender.currentTitle
        searchResult.text = viewModel.searchWord(word: sender.currentTitle!)
        updateButtonText()
    }
    
}

