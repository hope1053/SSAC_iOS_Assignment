//
//  coinedWord.swift
//  SSAC_Day5_newlyCoinedWord
//
//  Created by 최혜린 on 2021/10/03.
//

import Foundation

class WordManager {
    static let shared = WordManager()
    
    let wordList: [String: String] = ["삼귀자":"연애를 시작하기 전 썸 단계", "윰차":"구독자 유무 차별", "실매":"실시간 매니저", "만만잘부":"만나서 반가워 잘 부탁해", "꾸안꾸":"꾸민 듯 안 꾸민듯", "얼죽아":"얼어 죽어도 아이스 아메리카노", "복세편살":"복잡한 세상 편하게 살자", "자만추":"자연스러운 만남 추구", "댕댕이":"멍멍이", "갑통알":"갑자기 통장을 보니 알바해야 할 것 같다", "오놀아놈":"오 놀 줄 아는 놈인가?", "영고":"영원히 고통받는", "별다줄":"별걸 다 줄인다", "오저치고":"오늘 저녁 치킨 고?"]
    
    func searchWord(word: String) -> String{
        if let result = wordList[word] {
            return result
        } else {
            return "no result"
        }
    }
}

class wordViewModel {
    private let manager = WordManager.shared
    
    func searchWord(word: String) -> String {
        return manager.searchWord(word: word)
    }
}
