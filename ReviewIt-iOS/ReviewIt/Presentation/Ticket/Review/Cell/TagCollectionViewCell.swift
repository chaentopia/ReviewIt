//
//  TagCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import UIKit

import SnapKit
import Then

final class TagCollectionViewCell: UICollectionViewCell {
    
    let tagButton = UIButton()
    
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
        tagButton.do {
            $0.setTitle("", for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.setTitleColor(.mainBurgundy, for: .selected)
            $0.setRoundBorder(borderColor: isSelected ? .mainBurgundy : .subGray1,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.contentEdgeInsets = UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9)
        }
    }
    
    private func setLayout() {
        self.addSubviews(tagButton)
        
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configCell(data: String) {
        tagButton.setTitle(data, for: .normal)
    }
}
