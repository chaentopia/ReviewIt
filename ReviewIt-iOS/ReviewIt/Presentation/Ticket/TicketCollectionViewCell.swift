//
//  TicketCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketCollectionViewCell: UICollectionViewCell {
    /// 리뷰완료 - true, 리뷰 전 - false
    var reviewStatus = false
    
    let titleLabel = UILabel()
    let reviewTag = BasePaddingLabel()
    let dateLabel = UILabel()
    let placeLabel = UILabel()
    let seatLabel = UILabel()
    
    let actorLabel = UILabel()
    lazy var actorCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: actorFlowLayout
    )
    private let actorFlowLayout = UICollectionViewFlowLayout()
    
    let reviewLabel = UILabel()
    lazy var reviewCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: reviewFlowLayout
    )
    private let reviewFlowLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.do {
            $0.setRoundBorder(borderColor: UIColor.mainBlack,
                                   borderWidth: 1,
                                   cornerRadius: 10)
        }
        
        titleLabel.do {
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        reviewTag.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.setRoundBorder(borderColor: .subGray1,
                              borderWidth: 1,
                              cornerRadius: 10)
        }
        
        dateLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
        }
        
        placeLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
        }
        
        seatLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
        }
        
        actorLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
            $0.text = StringLiterals.TicketMain.actor
        }
        
        reviewLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
            $0.text = StringLiterals.TicketMain.summary
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel,
                         reviewTag,
                         dateLabel,
                         placeLabel,
                         seatLabel,
                         actorLabel,
                         actorCollectionView,
                         reviewLabel,
                         reviewCollectionView
        )
        
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth).offset(-48.adjustedWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(14)
        }
        
        reviewTag.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(reviewStatus ? 92 : 14)
        }
        
        actorLabel.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(16)
            $0.leading.equalTo(titleLabel)
        }
        
        actorCollectionView.snp.makeConstraints {
            $0.centerY.equalTo(actorLabel)
            $0.leading.equalTo(actorLabel.snp.trailing).offset(12)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalTo(titleLabel)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.centerY.equalTo(reviewLabel)
            $0.leading.equalTo(reviewLabel.snp.trailing).offset(12)
        }
    }
    
    func configTicketCell(data: Ticket) {
        titleLabel.text = data.title
        dateLabel.text = DateFormatter.ticketDisplayFormatter.string(from: data.date)
        placeLabel.text = data.place
        seatLabel.text = "\(data.seat[0])층 \(data.seat[1])구역 \(data.seat[2])열 \(data.seat[3])번"
        
        reviewStatus = data.reviewStatus
        
        reviewTag.textColor = data.reviewStatus ? .mainBurgundy : .subGray1
        reviewTag.text = data.reviewStatus ? StringLiterals.TicketMain.tagFinish : StringLiterals.TicketMain.tagBefore
        reviewTag.setRoundBorder(borderColor: data.reviewStatus ? .mainBurgundy : .subGray1,
                                 borderWidth: 1,
                                 cornerRadius: 10)
        
        actorLabel.isHidden = !data.reviewStatus
        actorCollectionView.isHidden = !data.reviewStatus
        reviewLabel.isHidden = !data.reviewStatus
        reviewCollectionView.isHidden = !data.reviewStatus
        
        seatLabel.snp.remakeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(reviewStatus ? 92 : 14)
        }
    }
}
