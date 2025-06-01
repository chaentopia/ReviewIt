//
//  TicketTagViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketTagViewController: BaseViewController {
    let titleView = TitleView(title: StringLiterals.AddTicket.title,
                              isLeftButtonHidden: false,
                              isRightButtonHidden: true)
    let titleLabel = UILabel()
    
    let bottomView = UIView()
    let laterButton = UIButton()
    let nextButton = UIButton()
    
    override func setStyle() {
        self.view.backgroundColor = .mainWhite
        
        titleLabel.do {
            $0.text = StringLiterals.AddTag.titleLabel
            $0.font = .fontReviewIT(.title_semibold_20)
            $0.textColor = .mainBlack
        }
        
        bottomView.do {
            $0.backgroundColor = .mainWhite
        }
        
        laterButton.do {
            $0.setTitle(StringLiterals.AddTag.laterButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_12)
            $0.setUnderline(forText: StringLiterals.AddTag.laterButton)
        }
        
        nextButton.do {
            $0.setRoundBorder(borderColor: UIColor.mainBlack,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.setTitle(StringLiterals.AddTag.reviewButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.setBackgroundColor(.subGray2, for: .normal)
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleView,
                         titleLabel,
                         bottomView)
        
        bottomView.addSubviews(laterButton,
                               nextButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(102)
        }
        
        laterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(5)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    override func setAddTarget() {
        titleView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        laterButton.addTarget(self, action: #selector(laterButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func laterButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
