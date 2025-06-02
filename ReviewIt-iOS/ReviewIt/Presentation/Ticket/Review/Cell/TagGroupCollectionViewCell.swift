//
//  TagGroupCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import UIKit

import SnapKit
import Then

final class TagGroupCollectionViewCell: UICollectionViewCell {
    
    var filterOnTap: ((Int) -> Void)?

    let titleList = ["극의 유형은?", "무대는 어땠나요?", "가장 좋았던 배우는?", "음향은 어땠나요?", "내용은 어땠나요?", "전반적으로 어땠나요?"]
    var tagList: [String] = []

    var selectedIndices: [Int] = []
    var onTagSelected: ((Int) -> Void)?
    
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
    
    func configCell(data: Int, selectedIndices: [Int]) {
            titleLabel.text = titleList[data]
            self.selectedIndices = selectedIndices
            tagCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.collectionViewHeightConstraint?.update(offset: self.tagCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }
}

extension TagGroupCollectionViewCell: UICollectionViewDelegate { }

extension TagGroupCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCollectionViewCell.className,
            for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.configTagCell(data: tagList[indexPath.item],
                       isSelected: selectedIndices.contains(indexPath.item))

        cell.onTap = { [weak self] in
            self?.onTagSelected?(indexPath.item)
            self?.filterOnTap?(indexPath.item)
        }

        return cell
    }
}
