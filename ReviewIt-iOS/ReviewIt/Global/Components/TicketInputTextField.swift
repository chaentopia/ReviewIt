//
//  TicketInputTextField.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketInputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: CGRect())
        setUI()
        self.changePlaceholderColor(forPlaceHolder: title, forColor: .subGray1)
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
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.returnKeyType = .done
            $0.addPadding(left: 16)
            $0.changePlaceholderColor(forPlaceHolder: "", forColor: .subGray1)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
        }
    }
    
    private func setLayout() {
        
    }
}
