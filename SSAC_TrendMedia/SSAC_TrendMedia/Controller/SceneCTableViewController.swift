//
//  SceneCTableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import JGProgressHUD

class SceneCTableViewController: UITableViewController {
    
    var currentMedia: Media? {
        didSet {
            mediaID = currentMedia?.mediaID
            if let poster = currentMedia?.posterImage {
                posterURL = URL(string: EndPoint.TMDB_IMAGE_URL + poster)
            }
            if let backdrop = currentMedia?.backdrop {
                backdropURL = URL(string: EndPoint.TMDB_IMAGE_URL + backdrop)
            }
        }
    }
    
    let progress = JGProgressHUD()
    
    var posterURL: URL?
    var backdropURL: URL?
    var mediaID: Int?
    
    var castList: [Cast] = []
    var crewList: [Crew] = []
    
    var isButtonClicked = false
    
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerPosterImageView: UIImageView!
    @IBOutlet var headerTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        
        headerPosterImageView.kf.setImage(with: posterURL)
        headerImageView.kf.setImage(with: backdropURL)
        headerTitleLabel.text = currentMedia?.title
        
        let nibName = UINib(nibName: SummaryTableViewCell.identifier, bundle: nil)
        detailTableView.register(nibName, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        
        fetchCreditData(mediaID!)
    }
    
    func fetchCreditData(_ mediaID: Int) {
        progress.textLabel.text = "불러오는 중..."
        progress.show(in: view, animated: true)
        guard let mediaType = currentMedia?.mediaType else {return}
        var url = ""
        
        if mediaType == "movie" {
            url = "https://api.themoviedb.org/3/movie/\(mediaID)/credits?api_key=\(Constants.API_KEY_TMDB)&language=en-US"
        } else {
            url = "https://api.themoviedb.org/3/tv/\(mediaID)/credits?api_key=\(Constants.API_KEY_TMDB)&language=en-US"
        }
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for castInfo in json["cast"].arrayValue {
                    let name = castInfo["name"].stringValue
                    let character = castInfo["character"].stringValue
                    let profileURL = castInfo["profile_path"].stringValue
                    
                    let newCast = Cast(original_name: name, character: character, profile_path: profileURL)
                    self.castList.append(newCast)
                }
                
                for crewInfo in json["crew"].arrayValue {
                    let name = crewInfo["original_name"].stringValue
                    let job = crewInfo["job"].stringValue
                    
                    let newCrew = Crew(original_name: name, job: job)
                    self.crewList.append(newCrew)
                }
                
                self.tableView.reloadData()
                self.progress.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func upDownButtonTapped(selectedButton: UIButton) {
        isButtonClicked = !isButtonClicked
        detailTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : section == 1 ? castList.count : crewList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Cast" : section == 2 ? "Crew" : ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            
            let image = isButtonClicked == true ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            
            cell.upDownButton.setImage(image, for: .normal)
            cell.summaryLabel.text = currentMedia?.overview
            cell.upDownButton.addTarget(self, action: #selector(upDownButtonTapped(selectedButton:)), for: .touchUpInside)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SceneCCell", for: indexPath) as? SceneCTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.section == 1 {
                let row = castList[indexPath.row]
                cell.nameLabel.text = row.original_name
                cell.roleLabel.text = row.character
                
                cell.castImageView.contentMode = .scaleAspectFill
                
                if row.profile_path == "" {
                    cell.castImageView.image = UIImage(systemName: "person.fill")
                } else {
                    let url = URL(string: EndPoint.TMDB_IMAGE_URL + row.profile_path)
                    cell.castImageView.kf.setImage(with: url)
                }
            } else {
                let row = crewList[indexPath.row]
                cell.nameLabel.text = row.original_name
                cell.roleLabel.text = row.job
                cell.castImageView.contentMode = .scaleAspectFit
                cell.castImageView.image = UIImage(systemName: "person.fill")
            }
            cell.castImageView.layer.cornerRadius = 10
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 && isButtonClicked ? UITableView.automaticDimension : UIScreen.main.bounds.height / 10
    }
}
