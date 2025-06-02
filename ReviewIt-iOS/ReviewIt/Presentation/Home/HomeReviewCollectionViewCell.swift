//
//  HomeReviewCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class HomeReviewCollectionViewCell: UICollectionViewCell {
    
    var textList: [String] = []
    var tagList: [[Int]] = [[], [], [], [], [], []]
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let nameLabel = UILabel()
    
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
        
        dateLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
        }
        
        nameLabel.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBlack
        }
        
        reviewCollectionView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
        }
        
        reviewFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 5
            $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel,
                         dateLabel,
                         nameLabel,
                         reviewCollectionView
        )
        
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(128.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(14)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(29)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
    private func setCollectionView() {
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        reviewCollectionView.register(TicketMainPreviewCollectionViewCell.self, forCellWithReuseIdentifier: TicketMainPreviewCollectionViewCell.className)
    }
    
    func configTicketCell(data: Ticket) {
        titleLabel.text = data.title
        dateLabel.text = DateFormatter.ticketDisplayFormatter.string(from: data.date)
        nameLabel.text = "user1234"
        tagList = data.typeList
        changeText()
        reviewCollectionView.reloadData()
    }
    
    func changeText() {
        tagList.enumerated().forEach { (typeIndex, type) in
            type.forEach { index in
                textList.append(typeList[typeIndex][index])
            }
        }
    }
}

extension HomeReviewCollectionViewCell: UICollectionViewDelegate { }

extension HomeReviewCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.flatMap { $0 }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TicketMainPreviewCollectionViewCell.className,
            for: indexPath) as? TicketMainPreviewCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configNameTag(data: textList[indexPath.row])
        return cell
    }
}

extension HomeReviewCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = textList[indexPath.row]
        let font = UIFont.fontReviewIT(.body_semibold_12)
        
        // 텍스트 너비 측정
        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
        
        let cellWidth = ceil(textWidth) + 8
        let cellHeight: CGFloat = 29
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
