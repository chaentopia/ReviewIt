//
//  TitleView.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TitleView: UIView {
    
    var titleLabel = UILabel()
    var leftButton = UIButton()
    var rightButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, isLeftButtonHidden: Bool, isRightButtonHidden: Bool) {
        super.init(frame: CGRect())
        setUI()
        titleLabel.text = title
        leftButton.isHidden = isLeftButtonHidden
        rightButton.isHidden = isRightButtonHidden
    }
}

extension TitleView {
    func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        titleLabel.do {
            $0.text = ""
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        leftButton.do {
            $0.setImage(.btnBack, for: .normal)
        }
        
        rightButton.do {
            $0.setImage(.btnEdit, for: .normal)
        }
    }
    
    func setLayout() {
        self.addSubviews(titleLabel,
        leftButton,
        rightButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
