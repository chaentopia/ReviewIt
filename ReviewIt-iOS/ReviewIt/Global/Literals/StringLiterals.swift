//
//  StringLiterals.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import Foundation

enum StringLiterals {
    
    enum TicketMain {
        static let title = "내 티켓 모아보기"
        static let tagBefore = "리뷰 전"
        static let tagFinish = "리뷰완료"
        static let actor = "최고의 배우"
        static let summary = "한 줄 요약"
    }
    
    enum TicketDetail {
        static let title = "후기 작성하기"
        static let titleLabel = "REVIEW it!"
        static let titlePlaceHolder = "제목을 입력하세요"
        static let castPlaceHolder = "캐스팅을 입력하세요 (쉼표로 구분)"
        static let placePlaceHolder = "공연장을 입력하세요"
        static let seatLabel = "좌석"
        static let platformPlaceHolder = "예매처를 입력하세요"
        static let pricePlaceHolder = "금액을 입력하세요"
        static let laterButton = "저장하고 후기는 나중에"
        static let reviewButton = "후기 쓰러 가기"
        static let doneButton = "완료"
    }
    
    enum Home {
        static let title = "후기 구경하기"
    }
    
    enum More {
        static let title = "더보기"
        static let logout = "로그아웃"
        static let delete = "탈퇴"
    }
}
