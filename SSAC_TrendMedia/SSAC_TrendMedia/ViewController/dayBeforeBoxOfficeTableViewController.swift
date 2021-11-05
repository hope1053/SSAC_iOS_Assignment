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
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    
    let localRealm = try! Realm()
    var boxOfficeList: Results<dayBeforeBoxOffice>?
    let progress = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: dayBeforeBoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: dayBeforeBoxOfficeTableViewCell.identifier)
        
        setButtonTitle(Date().dayBefore)
        
//        fetchData()
    }
    
    func setButtonTitle(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        dateButton.setTitle(formatter.string(from: date), for: .normal)
    }
    // 현재 데이트 설정돼있는걸 기반으로 데이터 저장돼있는지 확인하고 불러오는 코드
    
//    func fetchData() {
//        // 불러온적 없는 경우, 아직 data가 필요함 -> 서버와 연결~ 데이터 저장하고 이걸 보여주면 됨
//        if localRealm.objects(dayBeforeBoxOffice.self).isEmpty {
//            progress.textLabel.text = "불러오는 중..."
//            progress.show(in: view, animated: true)
//
//            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Constants.API_KEY_MOVIE)&targetDt=\(dayBefore)"
//
//            AF.request(url, method: .get).validate().responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    let newBoxOffice = dayBeforeBoxOffice()
//                    for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//                        let title = item["movieNm"].stringValue
//                        newBoxOffice.boxOfficeList.append(title)
//                    }
//                    try! self.localRealm.write {
//                        self.localRealm.add(newBoxOffice)
//                    }
//                    self.boxOfficeList = self.localRealm.objects(dayBeforeBoxOffice.self)
//                    self.boxOfficeTableView.reloadData()
//                    self.progress.dismiss(animated: true)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        } else {
//            // 데이터가 저장돼있음 -> 불러오면 됨
//            boxOfficeList = localRealm.objects(dayBeforeBoxOffice.self)
//            boxOfficeTableView.reloadData()
//        }
//    }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        datePicker = UIDatePicker.init()
//
//        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.date = Date().dayBefore
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height / 5 * 3 , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height / 5 * 2)
        self.view.addSubview(datePicker)
                
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height / 5 * 3, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.isTranslucent = true
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.tintColor = .white
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
            
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
        }
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
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
