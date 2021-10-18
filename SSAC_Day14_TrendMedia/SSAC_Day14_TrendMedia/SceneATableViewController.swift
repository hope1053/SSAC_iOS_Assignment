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
        cell.genreLabel.text = "#\(tvShowInfo.genre)"
        cell.posterImageView.image = UIImage(named: tvShowInfo.title)
        cell.rateLabel.text = "\(tvShowInfo.rate)"
        cell.titleLabel.text = tvShowInfo.title
        cell.starring.text = tvShowInfo.starring
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5 * 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SceneC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SceneCTableViewController") as! SceneCTableViewController
        vc.currentTvShow = tvShowInformation.tvShow[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "SceneB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SceneBTableViewController") as! SceneBTableViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}

