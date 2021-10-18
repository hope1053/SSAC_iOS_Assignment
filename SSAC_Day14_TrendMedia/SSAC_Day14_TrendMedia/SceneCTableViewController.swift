//
//  SceneCTableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit
import Kingfisher

class SceneCTableViewController: UITableViewController {
    
    var currentTvShow: TvShow?
    var starring: String = ""
    var starringList: [String] = []
    var tvShowName: String?
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerPosterImageView: UIImageView!
    @IBOutlet var headerTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        starring = currentTvShow!.starring
        tvShowName = currentTvShow?.title
        starringList = starring.components(separatedBy: ", ")
        updateUI()
    }
    
    func updateUI() {
        headerPosterImageView.image = UIImage(named: tvShowName!)
        headerTitleLabel.text = tvShowName!
        let url = URL(string: currentTvShow!.backdropImage)
        headerImageView.kf.setImage(with: url)
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
