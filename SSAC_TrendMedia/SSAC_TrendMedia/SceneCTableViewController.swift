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
    
    var isButtonClicked = false
    
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
        isButtonClicked = !isButtonClicked
        detailTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
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
            
            let image = isButtonClicked == true ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            
            cell.upDownButton.setImage(image, for: .normal)
            cell.summaryLabel.text = currentTvShow?.overview
            cell.upDownButton.addTarget(self, action: #selector(upDownButtonTapped(selectedButton:)), for: .touchUpInside)
            print(cell.bounds.height)
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
        if indexPath.section == 1 {
            return UIScreen.main.bounds.height / 10
        } else if indexPath.section == 0 && isButtonClicked {
            return UIScreen.main.bounds.height / 10
        } else {
            return UITableView.automaticDimension
        }
    }
}
