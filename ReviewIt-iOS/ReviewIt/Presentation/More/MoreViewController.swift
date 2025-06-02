//
//  MoreViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import KakaoSDKAuth
import SnapKit
import Then

final class MoreViewController: BaseViewController {
    private let titleView = TitleView(title: StringLiterals.More.title,
                                      isLeftButtonHidden: true,
                                      isRightButtonHidden: true)
    let nameLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 0))
    let logoutButton = UIButton()
    let deleteButton = UIButton()
    
    override func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setStyle() {
        super.setStyle()
        
        nameLabel.do {
            $0.setRoundBorder(borderColor: .mainBlack, borderWidth: 1, cornerRadius: 10)
            $0.text = UserInfo.shared.name
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        logoutButton.do {
            $0.setTitle(StringLiterals.More.logout, for: .normal)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.titleLabel?.textAlignment = .left
            $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 11, right: 0)
        }
        
        deleteButton.do {
            $0.setTitle(StringLiterals.More.delete, for: .normal)
            $0.setRoundBorder(borderColor: .subGray1, borderWidth: 1, cornerRadius: 10)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.titleLabel?.textAlignment = .left
            $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 11, right: 0)
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleView,
                              nameLabel,
                              logoutButton,
                              deleteButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth-48)
            $0.height.equalTo(85)
            $0.top.equalTo(titleView.snp.bottom).offset(16)
        }
        
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.width.equalTo(nameLabel)
            $0.height.equalTo(44)
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
        }
        
        deleteButton.snp.makeConstraints {
            $0.leading.trailing.width.equalTo(nameLabel)
            $0.height.equalTo(44)
            $0.top.equalTo(logoutButton.snp.bottom).offset(16)
        }
    }
   
    override func setAddTarget() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        print("로그아웃")
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
    }
    
    @objc private func deleteButtonTapped() {
        print("탈퇴")
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
    }
}
