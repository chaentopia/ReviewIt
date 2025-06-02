//
//  HomeViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    var ticketList: [Ticket] = []
    
    private let titleView = TitleView(title: StringLiterals.Home.title,
                                      isLeftButtonHidden: true,
                                      isRightButtonHidden: true)
    
    lazy var filterCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: filterFlowLayout
    )
    private let filterFlowLayout = UICollectionViewFlowLayout()
    
    lazy var reviewCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: reviewFlowLayout
    )
    private let reviewFlowLayout = UICollectionViewFlowLayout()
    
    let emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setStyle() {
        super.setStyle()
        
        emptyLabel.do {
            $0.text = StringLiterals.Home.empty
            $0.font = .fontReviewIT(.title_semibold_20)
            $0.textColor = .mainBlack
            $0.isHidden = true
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        
        filterCollectionView.do {
            $0.backgroundColor = .mainWhite
            $0.tag = 0
        }
        
        filterFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 8
            $0.sectionInset = UIEdgeInsets(top: 7, left: 0, bottom: 21, right: 0)
        }
        
        reviewCollectionView.do {
            $0.backgroundColor = .mainWhite
            $0.tag = 1
        }
        
        reviewFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 16
            $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 75.adjustedHeight
        
        self.view.addSubviews(titleView,
                              filterCollectionView,
                              reviewCollectionView,
                              emptyLabel)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        filterCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(titleView.snp.bottom)
            $0.height.equalTo(46)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(233.adjustedHeight)
        }
    }
    
    private func setCollectionView() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: TicketCollectionViewCell.className)
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        reviewCollectionView.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: TicketCollectionViewCell.className)
    }
}

extension HomeViewController: UICollectionViewDelegate { }

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 6
        case 1:
            emptyLabel.isHidden = !ticketList.isEmpty
            return ticketList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TicketCollectionViewCell.className,
                for: indexPath) as? TicketCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TicketCollectionViewCell.className,
                for: indexPath) as? TicketCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
