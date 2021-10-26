//
//  TranslateViewController.swift
//  SSAC_WEEK5_CLASS
//
//  Created by 최혜린 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {

    @IBOutlet var translatedText: UITextView!
    @IBOutlet var inputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":"J6_SoHpZG0H5O1jtkL6Z",
            "X-Naver-Client-Secret":"bEl_k79lLz"
        ]
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": inputText.text!
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.translatedText.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error):
                print(error)
            }
        }
    }
}
