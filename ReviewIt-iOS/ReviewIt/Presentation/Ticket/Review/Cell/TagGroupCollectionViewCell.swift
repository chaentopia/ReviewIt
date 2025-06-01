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
    
    let titleLabel = UILabel()
    lazy var tagCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: tagFlowLayout
    )
    private let tagFlowLayout = UICollectionViewFlowLayout()
    
    
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
        titleLabel.do {
            $0.text = "어땠나요?"
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        tagFlowLayout.do {
            $0.minimumLineSpacing = 8
            $0.minimumInteritemSpacing = 8
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel,
                         tagCollectionView)
        
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth).offset(48)
        }
    }
    
    func configCell(data: Int) {
        // 추후 추가
    }
}
