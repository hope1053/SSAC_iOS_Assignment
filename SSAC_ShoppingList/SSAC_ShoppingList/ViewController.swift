//
//  ViewController.swift
//  SSAC_Day11_ShoppingList
//
//  Created by 최혜린 on 2021/10/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shoppingList: [Shopping] = [] {
        didSet{
            updateUI()
            saveData()
        }
    }
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var shoppingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        updateUI()
        shoppingTable.rowHeight = UITableView.automaticDimension
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
    
    func saveData() {
        var tmpList: [[String: Any]] = []
        
        for product in shoppingList {
            let data: [String: Any] = [
                "whatToBuy": product.whatToBuy,
                "checkTapped": product.checkTapped,
                "starTapped": product.starTapped
            ]
            tmpList.append(data)
        }
        
        UserDefaults.standard.set(tmpList, forKey: "shoppingList")
        shoppingTable.reloadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "shoppingList") as? [[String: Any]] {
            var tmpList = [Shopping]()
            
            for datum in data {
                guard let whatToBuy = datum["whatToBuy"] as? String else {return}
                guard let starTapped = datum["starTapped"] as? Bool else {return}
                guard let checkTapped = datum["checkTapped"] as? Bool else {return}
                
                let currentProduct = Shopping(whatToBuy: whatToBuy, checkTapped: checkTapped, starTapped: starTapped)
                tmpList.append(currentProduct)
            }
            print(tmpList)
            self.shoppingList = tmpList
//            print(shoppingList)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as? shoppingCell else {
            return UITableViewCell()
        }
        
        let currentProduct = shoppingList[indexPath.row]
        cell.nameLabel.text = currentProduct.whatToBuy
        cell.starButton.isSelected = currentProduct.starTapped
        cell.checkButton.isSelected = currentProduct.checkTapped
        
        cell.background.layer.masksToBounds = true
        cell.background.layer.cornerRadius = 10
        
        cell.starButtonTapHandler = { isSelected in
            self.shoppingList[indexPath.row].starTapped = isSelected
        }
        
        cell.checkButtonTapHandler = { isSelected in
            self.shoppingList[indexPath.row].checkTapped = isSelected
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            saveData()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIScreen.main.bounds.height / 18
//    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
            let newProduct = Shopping(whatToBuy: newProduct, checkTapped: false, starTapped: false)
            shoppingList.append(newProduct)
        }

        inputTextField.text = ""
        saveData()
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
