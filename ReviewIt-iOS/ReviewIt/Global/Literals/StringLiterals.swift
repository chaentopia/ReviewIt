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
    
    enum AddTicket {
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
    }
    
    enum AddTag {
        static let titleLabel = "REVIEW it!"

        static let laterButton = "후기는 나중에"
        static let reviewButton = "작성 완료"
    }
    
    enum TicketDetail {
        static let title = "후기 보기"
        static let titleLabel = "REVIEW it!"
        static let seatLabel = "좌석"
        static let type1 = "극의 유형은?"
        static let type2 = "무대는 어땠나요?"
        static let type3 = "가장 좋았던 배우는?"
        static let type4 = "음향은 어땠나요?"
        static let type5 = "내용은 어땠나요?"
        static let type6 = "전반적으로 어땠나요?"
    }
    
    enum Home {
        static let title = "후기 구경하기"
    }
    
    enum More {
        static let title = "더보기"
        static let logout = "로그아웃"
        static let delete = "탈퇴"
        static let logoutTitle = "로그아웃 하시겠습니까?"
        static let deleteTitle = "탈퇴하시겠습니까?"
        static let deleteDescription = "탈퇴하시면 작성된 티켓은 모두 삭제됩니다."
        static let no = "아니요"
        static let deleteYes = "탈퇴"
        static let logoutYes = "로그아웃"
    }
}
