//
//  TicketMainPreviewCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketMainPreviewCollectionViewCell: UICollectionViewCell {
    
    let nameTag = BasePaddingLabel()

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
        nameTag.do {
            $0.font = .fontReviewIT(.body_semibold_12)
            $0.textColor = .mainBurgundy
            $0.setRoundBorder(borderColor: .mainBurgundy,
                              borderWidth: 1,
                              cornerRadius: 10)
        }
    }
    
    private func setLayout() {
        self.addSubviews(nameTag)
        
        nameTag.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configNameTag(data: String) {
        nameTag.text = data
    }
}
