//
//  TicketDetailLabel.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import UIKit

import SnapKit
import Then

final class TicketDetailLabel: BasePaddingLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.padding = UIEdgeInsets(top: 12, left: 16, bottom: 11, right: 16)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: CGRect())
        self.text = title
        self.padding = UIEdgeInsets(top: 12, left: 16, bottom: 11, right: 16)
        setUI()
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.do {
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
            $0.textAlignment = .left
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
        }
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth-48)
            $0.height.equalTo(44)
        }
    }
}
