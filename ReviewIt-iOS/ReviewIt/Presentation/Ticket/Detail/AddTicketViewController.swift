//
//  AddTicketViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class AddTicketViewController: BaseViewController {
    let titleView = TitleView(title: StringLiterals.TicketDetail.title,
                              isLeftButtonHidden: false,
                              isRightButtonHidden: true)
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let emptyImageView = UIImageView()
    let titleTextField = TicketInputTextField(title: StringLiterals.TicketDetail.titlePlaceHolder)
    let dateLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 12, left: 16, bottom: 11, right: 0))
    let castTextField = TicketInputTextField(title: StringLiterals.TicketDetail.castPlaceHolder)
    let placeTextField = TicketInputTextField(title: StringLiterals.TicketDetail.placePlaceHolder)
    
    let seatLabel = UILabel()
    let seatStackView = UIStackView()
    let seatFloorLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9))
    let seatSectionLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9))
    let seatRowLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9))
    let seatNumLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9))
    
    let platformTextField = TicketInputTextField(title: StringLiterals.TicketDetail.platformPlaceHolder)
    let priceTextField = TicketInputTextField(title: StringLiterals.TicketDetail.pricePlaceHolder)
    
    let bottomView = UIView()
    let laterButton = UIButton()
    let nextButton = UIButton()
    
    override func setStyle() {
        titleLabel.do {
            $0.text = StringLiterals.TicketDetail.titleLabel
            $0.font = .fontReviewIT(.title_semibold_20)
            $0.textColor = .mainBlack
        }
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
        }
        
        posterImageView.do {
            $0.setRoundBorder(borderColor: .subGray1,
                              borderWidth: 1,
                              cornerRadius: 10)
        }
        
        emptyImageView.do {
            $0.image = .empty
        }
        
        dateLabel.do {
            $0.setRoundBorder(borderColor: UIColor.subGray1, borderWidth: 1, cornerRadius: 10)
            $0.textColor = .mainBlack
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textAlignment = .left
            $0.text = DateFormatter.ticketDisplayFormatter.string(from: Date.now)
        }
        
        seatLabel.do {
            $0.text = StringLiterals.TicketDetail.seatLabel
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        seatFloorLabel.do {
            $0.text = "1층"
            $0.textColor = .mainBlack
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
        }
        
        seatSectionLabel.do {
            $0.text = "A구역"
            $0.textColor = .mainBlack
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
        }
        
        seatRowLabel.do {
            $0.text = "1열"
            $0.textColor = .mainBlack
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
        }
        
        seatNumLabel.do {
            $0.text = "1번"
            $0.textColor = .mainBlack
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
        }
        
        seatStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        bottomView.do {
            $0.backgroundColor = .mainWhite
        }
        
        laterButton.do {
            $0.setTitle(StringLiterals.TicketDetail.laterButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_12)
            $0.setUnderline(forText: StringLiterals.TicketDetail.laterButton)
        }
        
        nextButton.do {
            $0.setRoundBorder(borderColor: UIColor.mainBlack,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.setTitle(StringLiterals.TicketDetail.reviewButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.setBackgroundColor(.subGray2, for: .normal)
        }
    }
    
    override func setLayout() {
        view.addSubviews(scrollView,
                         titleView,
                         bottomView)
        
        scrollView.addSubviews(titleLabel,
                               posterImageView,
                               titleTextField,
                               dateLabel,
                               castTextField,
                               placeTextField,
                               seatLabel,
                               seatStackView,
                               platformTextField,
                               priceTextField)
        
        seatStackView.addArrangedSubviews(seatFloorLabel,
                                          seatSectionLabel,
                                          seatRowLabel,
                                          seatNumLabel)
        
        posterImageView.addSubviews(emptyImageView)
        
        bottomView.addSubviews(laterButton,
                               nextButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalTo(bottomView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
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
        
        emptyImageView.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        posterImageView.snp.makeConstraints {
            $0.size.equalTo(95)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(44)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        castTextField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        placeTextField.snp.makeConstraints {
            $0.top.equalTo(castTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(placeTextField.snp.bottom).offset(16)
            $0.leading.equalTo(titleTextField)
        }
        
        seatStackView.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleTextField)
        }
        
        platformTextField.snp.makeConstraints {
            $0.top.equalTo(seatStackView.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(platformTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
            $0.bottom.equalToSuperview().inset(21)
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
        // 다 작성되었는지 확인하는 로직 + 저장 로직
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func nextButtonTapped() {
        // 저장 로직
        let ticketTagViewController = TicketTagViewController()
        self.navigationController?.pushViewController(ticketTagViewController, animated: true)
    }
}
