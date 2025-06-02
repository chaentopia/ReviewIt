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
let type1List = ["힐링극", "코미디극", "피폐물", "추리극", "오열극", "생각이 많아지는 극", "로맨스극", "성장극", "실험극", "판타지극"]
let type2List = ["연출이 좋았음", "독특함" ,"조명이 좋았음", "무난함", "소품이 좋았음", "의상이 좋았음", "아쉬움", "화려함", "심플"]
let type3List = ["옥주현", "윤소호", "노윤", "윤사봉", "김주호", "그 외"]
let type4List = ["안정적인 라이브", "중독성 강한 넘버", "잘 안 들림", "음악 타이밍이 좋았음", "감정과 음악이 잘 어우러짐", "밸런스가 아쉬움", "라이브 아쉬움"]
let type5List = ["감동적이었음", "이해가 잘 됨", "공감됨", "기대 이상", "기대 이하", "뻔함", "어려웠음", "지루했음", "웃겼음"]
let type6List = ["인생 공연", "재관람 의향 있음", "눈물을 흘렸음", "한 번만 보기 좋음", "다른 캐스팅이 궁금", "무난함", "힐링되었음", "여운이 남음", "아쉬웠음"]
