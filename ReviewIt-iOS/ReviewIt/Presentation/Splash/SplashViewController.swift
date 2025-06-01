//
//  SplashViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class SplashViewController: BaseViewController {
    
    let logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToNextScreen()
    }
    
    override func setStyle() {
        view.backgroundColor = .mainBurgundy
        logoImageView.image = .reviewItLogo
    }
    
    override func setLayout() {
        self.view.addSubviews(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func navigateToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            var nextViewController: UIViewController
        
            nextViewController = MainTabBarViewController()
            
            let navigationController = UINavigationController(rootViewController: nextViewController)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }   
    }
}
