//
//  dayBeforeBoxOfficeTableViewController.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

class dayBeforeBoxOfficeTableViewController: UITableViewController {
        
    @IBOutlet var yesterdayLabel: UILabel!
    @IBOutlet var boxOfficeTableView: UITableView!
    
    var dayBeforeBoxOffice: [String] = []
    
    let progress = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: dayBeforeBoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: dayBeforeBoxOfficeTableViewCell.identifier)
        
        fetchData()
    }
    
    func fetchData() {
        progress.textLabel.text = "불러오는 중..."
        progress.show(in: view, animated: true)
        let date = Date().dayBefore
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dayBefore = formatter.string(from: date)
        
        formatter.dateFormat = "yyyy.MM.dd"
        yesterdayLabel.text = formatter.string(from: date)
        
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Constants.API_KEY_MOVIE)&targetDt=\(dayBefore)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let title = item["movieNm"].stringValue
                    self.dayBeforeBoxOffice.append(title)
                }
                self.boxOfficeTableView.reloadData()
                self.progress.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayBeforeBoxOffice.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dayBeforeBoxOfficeTableViewCell.identifier, for: indexPath) as? dayBeforeBoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.rankLabel.text = "\(indexPath.row + 1)위"
        cell.titleLabel.text = "\(dayBeforeBoxOffice[indexPath.row])"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 16
    }
}
