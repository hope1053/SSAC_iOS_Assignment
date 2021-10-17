//
//  SceneCTableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit

class SceneCTableViewController: UITableViewController {

    var starring: String = ""
    var starringList: [String] = []
    var tvShowName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        starringList = starring.components(separatedBy: ", ")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return starringList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SceneCCell", for: indexPath) as? SceneCTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = starringList[indexPath.row]
        cell.castImageView.image = UIImage(named: tvShowName!)
        cell.castImageView.layer.cornerRadius = 10
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
}
