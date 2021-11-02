//
//  ViewController.swift
//  SSAC_Day11_ShoppingList
//
//  Created by 최혜린 on 2021/10/13.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var shoppingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = localRealm.objects(ShoppingList.self)
        updateUI()
        shoppingTable.rowHeight = UITableView.automaticDimension
    }

    func updateUI() {
        if tasks.isEmpty {
            alertLabel.alpha = 1
        } else {
            alertLabel.alpha = 0
        }
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as? shoppingCell else {
            return UITableViewCell()
        }
        
        let currentProduct = tasks[indexPath.row]
        
        cell.nameLabel.text = currentProduct.content
        cell.starButton.isSelected = currentProduct.favorite
        cell.checkButton.isSelected = currentProduct.isDone
        
        cell.background.layer.masksToBounds = true
        cell.background.layer.cornerRadius = 10
        
//        cell.starButtonTapHandler = { isSelected in
//            self.shoppingList[indexPath.row].starTapped = isSelected
//        }
//
//        cell.checkButtonTapHandler = { isSelected in
//            self.shoppingList[indexPath.row].checkTapped = isSelected
//        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            shoppingList.remove(at: indexPath.row)
//            saveData()
//        }
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 16
    }
    
    @IBAction func addList(_ sender: UIButton) {
        guard let newProduct = inputTextField.text else {return}
        if newProduct == "" {
            let alert = UIAlertController(title: "목록을 입력해주세요!", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(OK)
            present(alert, animated: true, completion: nil)
        } else {
            let task = ShoppingList(content: newProduct)
            try! localRealm.write {
                localRealm.add(task)
            }
            tasks = localRealm.objects(ShoppingList.self)
            shoppingTable.reloadData()
            print("Realm is located at:", localRealm.configuration.fileURL!)
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
