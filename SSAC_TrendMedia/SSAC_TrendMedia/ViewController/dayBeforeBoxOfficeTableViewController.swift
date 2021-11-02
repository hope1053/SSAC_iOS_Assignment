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
import RealmSwift

class dayBeforeBoxOfficeTableViewController: UITableViewController {
        
    @IBOutlet var yesterdayLabel: UILabel!
    @IBOutlet var boxOfficeTableView: UITableView!
    
    let localRealm = try! Realm()
    var boxOfficeList: Results<dayBeforeBoxOffice>?
    let progress = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: dayBeforeBoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: dayBeforeBoxOfficeTableViewCell.identifier)
        
        fetchData()
    }
    
    func fetchData() {
        // 불러온적 없는 경우, 아직 data가 필요함 -> 서버와 연결~ 데이터 저장하고 이걸 보여주면 됨
        if localRealm.objects(dayBeforeBoxOffice.self).isEmpty {
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
                    let newBoxOffice = dayBeforeBoxOffice()
                    for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                        let title = item["movieNm"].stringValue
                        newBoxOffice.boxOfficeList.append(title)
                    }
                    try! self.localRealm.write {
                        self.localRealm.add(newBoxOffice)
                    }
                    self.boxOfficeList = self.localRealm.objects(dayBeforeBoxOffice.self)
                    self.boxOfficeTableView.reloadData()
                    self.progress.dismiss(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            // 데이터가 저장돼있음 -> 불러오면 됨
            boxOfficeList = localRealm.objects(dayBeforeBoxOffice.self)
            boxOfficeTableView.reloadData()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList?[0].boxOfficeList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dayBeforeBoxOfficeTableViewCell.identifier, for: indexPath) as? dayBeforeBoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.rankLabel.text = "\(indexPath.row + 1)위"
        cell.titleLabel.text = "\(boxOfficeList![0].boxOfficeList[indexPath.row])"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 16
    }
}
