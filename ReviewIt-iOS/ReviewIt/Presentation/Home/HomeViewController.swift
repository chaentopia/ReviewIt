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
    var ticketList: [Ticket] = [Ticket(id: 0,
                                       title: "마타하리",
                                       date: Date.now,
                                       cast: ["노윤", "옥주현"],
                                       place: "LG이트센터서울 LG SIGNATURE홀",
                                       seat: ["1", "A", "3", "20"],
                                       platform: "멜론티켓",
                                       price: 1300000,
                                       reviewStatus: true,
                                       typeList: [[0,1,2], [0,4,5], [1, 2], [1], [1,2], [1,2,3,4,5]]),
                                Ticket(id: 0,
                                       title: "리지",
                                       date: Date.now,
                                       cast: ["이아름솔", "김소향"],
                                       place: "두산아트센터 연강홀",
                                       seat: ["1", "-", "1", "349"],
                                       platform: "인터파크티켓",
                                       price: 50000,
                                       reviewStatus: true,
                                       typeList: [[0,1,2], [0,4,5], [1, 2], [1], [1,2], [1,2,3,4,5]])]
    
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
            $0.showsHorizontalScrollIndicator = false
        }
        
        filterFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 8
            $0.sectionInset = UIEdgeInsets(top: 21, left: 16, bottom: 21, right: 16)
        }
        
        reviewCollectionView.do {
            $0.backgroundColor = .mainWhite
            $0.tag = 1
            $0.contentInset = UIEdgeInsets(top: 11, left: 24, bottom: 24, right: 21)
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
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
            $0.top.equalTo(titleView.snp.bottom).offset(7)
            $0.height.equalTo(50)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
            $0.top.equalTo(filterCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
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
        filterCollectionView.register(HomeFilterCollectionViewCell.self, forCellWithReuseIdentifier: HomeFilterCollectionViewCell.className)
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        reviewCollectionView.register(HomeReviewCollectionViewCell.self, forCellWithReuseIdentifier: HomeReviewCollectionViewCell.className)
    }
    
    @objc private func pushToDetail(_ sender: UITapGestureRecognizer) {
        let ticketDetailViewController = TicketDetailViewController()
        ticketDetailViewController.isMyReview = false
        
        guard let cell = sender.view as? HomeReviewCollectionViewCell else { return }
        guard let indexPath = reviewCollectionView.indexPath(for: cell) else { return }
        ticketDetailViewController.ticketData = ticketList[indexPath.row]
        
        ticketDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ticketDetailViewController, animated: true)
    }
    
    private func showSheet() {
        let filterBottomSheetViewController = FilterBottomSheetViewController()
        if let sheet = filterBottomSheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        present(filterBottomSheetViewController, animated: true, completion: nil)
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
                withReuseIdentifier: HomeFilterCollectionViewCell.className,
                for: indexPath) as? HomeFilterCollectionViewCell else { return UICollectionViewCell() }
            cell.configTagCell(data: indexPath.row, isSelected: false) // false 값 변경 필요
            cell.onTap = {
                self.showSheet()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeReviewCollectionViewCell.className,
                for: indexPath) as? HomeReviewCollectionViewCell else { return UICollectionViewCell() }
            cell.configTicketCell(data: ticketList[indexPath.item])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushToDetail(_:)))
            cell.addGestureRecognizer(tapGesture)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            
            let text: String
            let font = UIFont.fontReviewIT(.body_semibold_12)
            
            // 이거 나중에 텍스트로 바꿔야 힘
            text = StringLiterals.Home.type1
            
            // 텍스트 너비 측정
            let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
            
            let cellWidth = ceil(textWidth) + 10 + 24 + 18
            let cellHeight: CGFloat = 46
            
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            return CGSize(width: SizeLiterals.Screen.screenWidth - 48, height: 128.adjustedHeight)
        }
    }
}
