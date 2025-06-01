//
//  TabBarItems.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

enum TabBarItems: Int, CaseIterable {
    case ticket
    case home
    case more
}

extension TabBarItems {
    var Icon: UIImage? {
        switch self {
        case .ticket:         return UIImage(resource: .ticket)
        case .home:         return UIImage(resource: .home)
        case .more:      return UIImage(resource: .more)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .ticket:         return UIImage(resource: .ticketSelected).withRenderingMode(.alwaysOriginal)
        case .home:         return UIImage(resource: .homeSelected).withRenderingMode(.alwaysOriginal)
        case .more:      return UIImage(resource: .moreSelected).withRenderingMode(.alwaysOriginal)
        }
    }
}

extension TabBarItems {
    public func asTabBarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: nil,
            image: Icon,
            selectedImage: selectedIcon
        )
        
        return tabBarItem
    }
}
