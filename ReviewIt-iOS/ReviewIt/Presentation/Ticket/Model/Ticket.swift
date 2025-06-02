//
//  Ticket.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import Foundation

struct Ticket: Codable {
    let id: Int
    let title: String
    let date: Date
    let cast: [String]
    let place: String
    let seat: [String]
    let platform: String
    let price: Int
    
    let reviewStatus: Bool
    
    let typeList: [[Int]]
    
    //let type1: [Int]
    //let type2: [Int]
    //let type3: [Int]
    //let type4: [Int]
    //let type5: [Int]
    //let type6: [Int]
}

let typeList = [type1List, type2List, type3List, type4List, type5List, type6List]
let type1List = ["힐링극", "코미디극", "피폐물", "추리극", "오열극", "로맨스극", "성장극", "실험극", "판타지극", "기타"]
let type2List = ["연출이 좋았음", "무대가 인상적", "소품이 좋았음", "의상이 좋았음", "아쉬움", "무대 활용이 좋았음", "허전함", "연기와 잘 어우러짐", "조명이 좋았음",]
let type3List = ["옥주현", "윤소호", "노윤", "윤사봉", "김주호", "그 외"]
let type4List = ["안정적인 라이브", "분위기가 좋음", "아쉬움", "지루함", "음악이 강렬함", "중독성 강한 넘버", "상황에 어울림", "잔잔한 음악", "음악 없음"]
let type5List = ["감동적", "기대 이상", "기대 이하", "뻔함", "이해가 잘 됨", "감정이입이 됨", "지루함", "어려웠음", "웃김", "공감됨"]
let type6List = ["또 보고싶다", "오열했다", "한 번만 보기 좋음", "재관람 의향 없음", "아쉬웠음", "여운이 남음", "다른 캐스팅이 궁금", "평소보다 좋았다"]
