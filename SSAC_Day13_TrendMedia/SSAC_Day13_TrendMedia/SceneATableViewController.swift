//
//  SceneATableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit

class SceneATableViewController: UITableViewController {

    let tvShowInformation = TvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHeaderView.updateUI()
    }
    @IBOutlet weak var tableHeaderView: UIView!
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as? SceneATableViewCell else {
            return UITableViewCell()
        }
        
        let tvShowInfo = tvShowInformation.tvShow[indexPath.row]
        
        cell.releaseDate.text = tvShowInfo.releaseDate
        cell.genre.text = "#\(tvShowInfo.genre)"
        cell.posterImage.image = UIImage(named: tvShowInfo.title)
        cell.rate.text = "\(tvShowInfo.rate)"
        cell.title.text = tvShowInfo.title
        cell.starring.text = tvShowInfo.starring
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5 * 3
    }
}
