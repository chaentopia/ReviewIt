//
//  MainTabBarViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class MainTabBarViewController: UITabBarController {
    
    private var tabsList: [UIViewController] = []
    
    let ticketViewController = TicketViewController()
    let homeViewController = HomeViewController()
    let moreViewController = MoreViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 75.adjustedHeight
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setTabs()
        setTabBarItems()
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .mainWhite
        self.tabBar.itemPositioning = .fill
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setTabs() {
        tabsList = [
            UINavigationController(rootViewController: ticketViewController),
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: moreViewController)
        ]
    }
    
    private func setTabBarItems() {
        self.setViewControllers(tabsList, animated: true)
        
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = .mainWhite
        tabBar.barStyle = UIBarStyle.default
        tabBar.barTintColor = .mainWhite
        
        TabBarItems.allCases.forEach {
            tabsList[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabsList[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
    }
}
