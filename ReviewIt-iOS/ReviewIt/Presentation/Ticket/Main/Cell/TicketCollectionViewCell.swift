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
    
    var actorList: [Int] = []
    var reviewList: [Int] = []
    
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
        setCollectionView()
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
        
        actorCollectionView.do {
            $0.tag = 1
            $0.showsHorizontalScrollIndicator = false
        }
        
        actorFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 5
        }
        
        reviewLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
            $0.text = StringLiterals.TicketMain.summary
        }
        
        reviewCollectionView.do {
            $0.tag = 2
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
        }
        
        reviewFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 5
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
            $0.trailing.equalTo(reviewTag)
            $0.height.equalTo(29)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalTo(titleLabel)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.centerY.equalTo(reviewLabel)
            $0.leading.equalTo(actorCollectionView)
            $0.trailing.equalTo(reviewTag)
            $0.height.equalTo(29)
        }
    }
    
    private func setCollectionView() {
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        actorCollectionView.register(TicketMainPreviewCollectionViewCell.self, forCellWithReuseIdentifier: TicketMainPreviewCollectionViewCell.className)
        reviewCollectionView.register(TicketMainPreviewCollectionViewCell.self, forCellWithReuseIdentifier: TicketMainPreviewCollectionViewCell.className)
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
        
        actorList = data.typeList[2]
        reviewList = data.typeList[5]
        actorCollectionView.reloadData()
        reviewCollectionView.reloadData()
    }
}

extension TicketCollectionViewCell: UICollectionViewDelegate { }

extension TicketCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return actorList.count
        case 2:
            return reviewList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TicketMainPreviewCollectionViewCell.className,
                for: indexPath) as? TicketMainPreviewCollectionViewCell else { return UICollectionViewCell() }
            cell.configNameTag(data: type3List[actorList[indexPath.item]])
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TicketMainPreviewCollectionViewCell.className,
                for: indexPath) as? TicketMainPreviewCollectionViewCell else { return UICollectionViewCell() }
            cell.configNameTag(data: type6List[reviewList[indexPath.item]])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension TicketCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let text: String
        let font = UIFont.fontReviewIT(.body_semibold_12)

        switch collectionView.tag {
        case 1:
            text = type3List[actorList[indexPath.item]]
        case 2:
            text = type6List[reviewList[indexPath.item]]
        default:
            return .zero
        }

        // 텍스트 너비 측정
        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width

        // 좌우 padding: 4 + 4 = 8
        let cellWidth = ceil(textWidth) + 8
        let cellHeight: CGFloat = 29

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
