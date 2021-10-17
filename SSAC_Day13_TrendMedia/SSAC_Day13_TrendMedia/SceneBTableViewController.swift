//
//  SceneTableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit

class SceneBTableViewController: UITableViewController {

    let tvShowInformation = TvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "영화 검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tvShowInformation.tvShow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SceneBCell", for: indexPath) as? SceneBTableViewCell else {
            return UITableViewCell()
        }
        
        let data = tvShowInformation.tvShow[indexPath.row]
        cell.posterImageView.image = UIImage(named: data.title)
        cell.titleLabel.text = data.title
        cell.releaseDate.text = "\(data.releaseDate)"
        cell.overview.text = data.overview
        
        return cell
    }
}
