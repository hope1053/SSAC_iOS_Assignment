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
    
    @IBOutlet var detailTableView: UITableView!
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

        let nibName = UINib(nibName: SummaryTableViewCell.identifier, bundle: nil)
        detailTableView.register(nibName, forCellReuseIdentifier: SummaryTableViewCell.identifier)
    }
    
    func updateUI() {
        headerPosterImageView.image = UIImage(named: tvShowName!)
        headerTitleLabel.text = tvShowName!
        let url = URL(string: currentTvShow!.backdropImage)
        headerImageView.kf.setImage(with: url)
    }
    
    @objc func upDownButtonTapped(selectedButton: UIButton) {
        selectedButton.isSelected = !selectedButton.isSelected
        detailTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 1 ? starringList.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            cell.summaryTextView.text = currentTvShow?.overview
            cell.upDownButton.addTarget(self, action: #selector(upDownButtonTapped(selectedButton:)), for: .touchUpInside)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SceneCCell", for: indexPath) as? SceneCTableViewCell else {
                return UITableViewCell()
            }
            
            cell.nameLabel.text = starringList[indexPath.row]
            cell.castImageView.image = UIImage(named: tvShowName!)
            cell.castImageView.layer.cornerRadius = 10
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
}
