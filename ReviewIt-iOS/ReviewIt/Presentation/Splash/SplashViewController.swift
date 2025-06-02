//
//  SplashViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import KakaoSDKAuth
import KakaoSDKUser
import SnapKit
import Then

final class SplashViewController: BaseViewController {
    
    let logoImageView = UIImageView()
    let kakaoLoginButton = UIButton()
    
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToNextScreen()
    }
    
    override func setAddTarget() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    override func setStyle() {
        view.backgroundColor = .mainBurgundy
        logoImageView.image = .reviewItLogo
        
        kakaoLoginButton.do {
            $0.setImage(.btnKakaoLogin, for: .normal)
            $0.alpha = 0
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(logoImageView,
                              kakaoLoginButton)
        
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(109)
            $0.height.equalTo(44)
        }
    }
    
    private func navigateToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            var nextViewController: UIViewController
            
            if self.isLogin {
                nextViewController = MainTabBarViewController()
                
                let navigationController = UINavigationController(rootViewController: nextViewController)
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                self.kakaoLoginButton.alpha = 1
            }
        }
    }
    
    @objc private func kakaoLoginButtonTapped() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            kakaoLoginWithApp()
        } else {
            kakaoLoginWithAccount()
        }
    }
    
    func kakaoLoginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                let nextViewController = MainTabBarViewController()
                let navigationController = UINavigationController(rootViewController: nextViewController)
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                self.isLogin = true
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("me() success.")
                        if let user = user {
                            if let kakaoUser = user.kakaoAccount?.profile {
                                if let name = kakaoUser.nickname {
                                    UserInfo.shared.name = name
                                    print("이름은\(name)")
                                }
                            }
                        }
                    }
                    _ = oauthToken
                }
            }
        }
    }
    
    func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                let nextViewController = MainTabBarViewController()
                let navigationController = UINavigationController(rootViewController: nextViewController)
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                self.isLogin = true
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("me() success.")
                        if let user = user {
                            if let kakaoUser = user.kakaoAccount?.profile {
                                if let name = kakaoUser.nickname {
                                    UserInfo.shared.name = name
                                    print("이름은\(name)")
                                }
                            }
                        }
                    }
                }
                _ = oauthToken
            }
        }
    }
}
