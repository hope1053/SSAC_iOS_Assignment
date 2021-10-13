//
//  ViewController.swift
//  SSAC_Day11_ShoppingList
//
//  Created by 최혜린 on 2021/10/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shoppingList: [String] = [] {
        didSet{
            shoppingTable.reloadData()
            updateUI()
        }
    }
    
    var checkBox: [Bool] = []
    var starButton: [Bool] = []
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var shoppingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        shoppingList = UserDefaults.standard.stringArray(forKey: "shoppingList") ?? []
        checkBox = UserDefaults.standard.array(forKey: "checkBox") as? [Bool] ?? []
        starButton = UserDefaults.standard.array(forKey: "starButton") as? [Bool] ?? []
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(shoppingList, forKey: "shoppingList")
        UserDefaults.standard.set(checkBox, forKey: "checkBox")
        UserDefaults.standard.set(starButton, forKey: "starButton")
    }

    func updateUI() {
        if shoppingList.isEmpty {
            alertLabel.alpha = 1
        } else {
            alertLabel.alpha = 0
        }
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as? shoppingCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = shoppingList[indexPath.row]
        cell.starButton.isSelected = starButton[indexPath.row]
        cell.checkButton.isSelected = checkBox[indexPath.row]
        cell.background.layer.masksToBounds = true
        cell.background.layer.cornerRadius = 10
        
        cell.starButtonTapHandler = { isSelected in
            self.starButton[indexPath.row] = isSelected
        }
        
        cell.checkButtonTapHandler = { isSelected in
            self.checkBox[indexPath.row] = isSelected
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            starButton.remove(at: indexPath.row)
            checkBox.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 18
    }
    
    @IBAction func addList(_ sender: UIButton) {
        guard let newProduct = inputTextField.text else {return}
        if newProduct == "" {
            let alert = UIAlertController(title: "목록을 입력해주세요!", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(OK)
            present(alert, animated: true, completion: nil)
        } else {
            shoppingList.append(newProduct)
            checkBox.append(false)
            starButton.append(false)
        }

        inputTextField.text = ""
    }
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
}

class shoppingCell: UITableViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    var starButtonTapHandler: ((Bool) -> Void)?
    var checkButtonTapHandler: ((Bool) -> Void)?
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        starButton.isSelected = !starButton.isSelected
        starButtonTapHandler?(starButton.isSelected)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        checkButton.isSelected = !checkButton.isSelected
        checkButtonTapHandler?(checkButton.isSelected)
    }
}
