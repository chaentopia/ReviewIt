//
//  TagGroupDetailCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import UIKit

import SnapKit
import Then

final class TagGroupDetailCollectionViewCell: UICollectionViewCell {
    
    let titleList = [StringLiterals.TicketDetail.type1,
                     StringLiterals.TicketDetail.type2,
                     StringLiterals.TicketDetail.type3,
                     StringLiterals.TicketDetail.type4,
                     StringLiterals.TicketDetail.type5,
                     StringLiterals.TicketDetail.type6]
    
    var tagList: [Int] = []
    var titleNum = 0
    
    let titleLabel = UILabel()
    lazy var tagCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: tagFlowLayout
    )
    private let tagFlowLayout = CollectionViewLeftAlignFlowLayout()
    
    private var collectionViewHeightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionViewHeightConstraint?.update(offset: tagCollectionView.collectionViewLayout.collectionViewContentSize.height)
    }

    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        titleLabel.do {
            $0.text = "어땠나요?"
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        tagFlowLayout.do {
            $0.minimumLineSpacing = 8
            $0.minimumInteritemSpacing = 8
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        tagCollectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .mainWhite
            $0.isUserInteractionEnabled = true
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel,
                         tagCollectionView)
        
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(174)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            self.collectionViewHeightConstraint = $0.height.equalTo(1).constraint
        }
    }
    
    private func setCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.className)
    }
    
    func configCell(data: Int, tagList: [Int]) {
        titleLabel.text = titleList[data]
        tagCollectionView.reloadData()
        self.tagList = tagList
        self.titleNum = data
        
        DispatchQueue.main.async {
            self.collectionViewHeightConstraint?.update(offset: self.tagCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }
}

extension TagGroupDetailCollectionViewCell: UICollectionViewDelegate { }

extension TagGroupDetailCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCollectionViewCell.className,
            for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.configTagCell(data: typeList[titleNum][indexPath.item],
                       isSelected: true)

        return cell
    }
}
