//
//  TicketViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketViewController: BaseViewController {
    
    private let titleView  = TitleView(title: StringLiterals.TicketMain.title,
                                       isLeftButtonHidden: true,
                                       isRightButtonHidden: true)
    lazy var ticketCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: ticketFlowLayout
    )
    private let ticketFlowLayout = UICollectionViewFlowLayout()
    lazy var addTicketButton = UIButton()
    
    override func setStyle() {
        super.setStyle()
        addTicketButton.do {
            $0.setImage(.btnAddTicket, for: .normal)
        }
        
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 75.adjustedHeight
        
        self.view.addSubviews(titleView,
                              ticketCollectionView,
                              addTicketButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.height.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        ticketCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        addTicketButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight - 18.adjustedHeight)
            $0.size.equalTo(60)
        }
    }
    
    override func setAddTarget() {
        addTicketButton.addTarget(self,
                                  action: #selector(pushAddTicketViewController),
                                  for: .touchUpInside)
    }
    
    @objc private func pushAddTicketViewController() {
        let addTicketViewController = AddTicketViewController()
        addTicketViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addTicketViewController, animated: true)
    }
}
