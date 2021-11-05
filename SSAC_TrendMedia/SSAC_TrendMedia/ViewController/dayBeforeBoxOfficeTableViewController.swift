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
        
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var boxOfficeTableView: UITableView!
    
    let localRealm = try! Realm()
    var boxOfficeList: Results<dayBeforeBoxOffice>?
    let progress = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: dayBeforeBoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: dayBeforeBoxOfficeTableViewCell.identifier)
        
        setButtonTitle(Date().dayBefore)
        fetchData()
    }
    
    func setButtonTitle(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        dateButton.setTitle(formatter.string(from: date), for: .normal)
    }
    // 현재 데이트 설정돼있는걸 기반으로 데이터 저장돼있는지 확인하고 불러오는 코드
    
    func fetchData() {
        // 불러온적 없는 경우, 아직 data가 필요함 -> 서버와 연결~ 데이터 저장하고 이걸 보여주면 됨
        if localRealm.objects(dayBeforeBoxOffice.self).filter("dateInfo == '\(dateButton.currentTitle!)'").isEmpty {
            progress.textLabel.text = "불러오는 중..."
            progress.show(in: view, animated: true)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            let daybeforeDate = formatter.date(from: dateButton.currentTitle!)!
            formatter.dateFormat = "yyyyMMdd"
            
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Constants.API_KEY_MOVIE)&targetDt=\(formatter.string(from: daybeforeDate))"

            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let newBoxOffice = dayBeforeBoxOffice()
                    for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                        let title = item["movieNm"].stringValue
                        newBoxOffice.boxOfficeList.append(title)
                    }
                    newBoxOffice.dateInfo = self.dateButton.currentTitle!

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
            boxOfficeList = localRealm.objects(dayBeforeBoxOffice.self).filter("dateInfo == '\(dateButton.currentTitle!)'")
            boxOfficeTableView.reloadData()
        }
    }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜를 선택하세요.", message: nil, preferredStyle: .alert)
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {return}
        alert.setValue(contentView, forKey: "contentViewController")
        
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePicker.date)
            // 확인 버튼을 눌렀을 때 버튼의 타이틀 변경
            self.dateButton.setTitle(value, for: .normal)
            self.fetchData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(ok)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList?[0].boxOfficeList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dayBeforeBoxOfficeTableViewCell.identifier, for: indexPath) as? dayBeforeBoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        let currentData = boxOfficeList?.filter("dateInfo == '\(dateButton.currentTitle!)'")
    
        cell.rankLabel.text = "\(indexPath.row + 1)위"
        cell.titleLabel.text = "\(currentData![0].boxOfficeList[indexPath.row])"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 16
    }
}
