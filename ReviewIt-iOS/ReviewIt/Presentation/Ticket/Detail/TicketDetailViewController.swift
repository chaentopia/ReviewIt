//
//  TicketDetailViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketDetailViewController: BaseViewController {
    
    var ticketData: Ticket = Ticket(id: 0,
                                    title: "마타하리",
                                    date: Date.now,
                                    cast: ["노윤", "옥주현"],
                                    place: "LG이트센터서울 LG SIGNATURE홀",
                                    seat: ["1", "A", "3", "20"],
                                    platform: "멜론티켓",
                                    price: 130000,
                                    reviewStatus: true,
                                    type1: [0,1,2],
                                    type2: [0,4,5],
                                    type3: ["노윤", "옥주현"],
                                    type4: [1],
                                    type5: [1,2],
                                    type6: ["인생 공연", "재관람 의사 있음", "레전드", "레전드", "한 번만 보기 좋음", "무난함"])
    
    private let titleView = TitleView(title: StringLiterals.TicketDetail.title,
                                       isLeftButtonHidden: false,
                                       isRightButtonHidden: false)
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let ticketTitleLabel = TicketDetailLabel()
    let dateTitleLabel = TicketDetailLabel()
    let castTitleLabel = TicketDetailLabel()
    let placeTitleLabel = TicketDetailLabel()
    
    let seatLabel = UILabel()
    let seatStackView = UIStackView()
    let seatFloorLabel = TicketSeatDetailLabel()
    let seatSectionLabel = TicketSeatDetailLabel()
    let seatRowLabel = TicketSeatDetailLabel()
    let seatNumLabel = TicketSeatDetailLabel()
    
    let platformTitleLabel = TicketDetailLabel()
    let priceTitleLabel = TicketDetailLabel()
    
    override func setStyle() {
        self.view.backgroundColor = .mainWhite

        titleLabel.do {
            $0.text = StringLiterals.AddTicket.titleLabel
            $0.font = .fontReviewIT(.title_semibold_20)
            $0.textColor = .mainBlack
        }
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
        }
        
        posterImageView.do {
            $0.setRoundBorder(borderColor: .subGray1,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.contentMode = .scaleAspectFit
        }
        
        ticketTitleLabel.do {
            $0.text = ticketData.title
        }
        
        dateTitleLabel.do {
            $0.text = DateFormatter.ticketDisplayFormatter.string(from: ticketData.date)
        }
        
        castTitleLabel.do {
            $0.text = ticketData.cast.joined(separator: ", ")
        }
        
        placeTitleLabel.do {
            $0.text = ticketData.place
        }
        
        seatLabel.do {
            $0.text = StringLiterals.AddTicket.seatLabel
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        seatStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.isUserInteractionEnabled = true
        }
        
        seatFloorLabel.do {
            $0.text = "\(ticketData.seat[0])층"
        }
        
        seatSectionLabel.do {
            $0.text = "\(ticketData.seat[1])구역"
        }
        
        seatRowLabel.do {
            $0.text = "\(ticketData.seat[2])열"
        }
        
        seatNumLabel.do {
            $0.text = "\(ticketData.seat[3])번"
        }
        
        platformTitleLabel.do {
            $0.text = ticketData.platform
        }
        
        priceTitleLabel.do {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "ko_KR")

            if let formattedPrice = formatter.string(from: NSNumber(value: ticketData.price)) {
                let result = "₩\(formattedPrice)"
                $0.text = result
            }
        }
    }
    
    override func setLayout() {
        view.addSubviews(scrollView,
                        titleView)
        
        scrollView.addSubviews(titleLabel,
                               posterImageView,
                               ticketTitleLabel,
                               dateTitleLabel,
                               castTitleLabel,
                               placeTitleLabel,
                               seatLabel,
                               seatStackView,
                               platformTitleLabel,
                               priceTitleLabel)
        
        seatStackView.addArrangedSubviews(seatFloorLabel,
                                          seatSectionLabel,
                                          seatRowLabel,
                                          seatNumLabel)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        posterImageView.snp.makeConstraints {
            $0.size.equalTo(95)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
        }
        
        ticketTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(44)
        }
        
        dateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(ticketTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        castTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dateTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        placeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(castTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(placeTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(ticketTitleLabel)
        }
        
        seatStackView.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(8)
            $0.leading.equalTo(ticketTitleLabel)
        }
        
        platformTitleLabel.snp.makeConstraints {
            $0.top.equalTo(seatStackView.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        priceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(platformTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
            $0.bottom.equalToSuperview().inset(21)
        }
    }
    
    override func setAddTarget() {
        titleView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        titleView.rightButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        // 정보 넘기는 로직 추가
        let addTicketViewController = AddTicketViewController()
        self.navigationController?.pushViewController(addTicketViewController, animated: true)
    }
}
