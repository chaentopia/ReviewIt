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
    
    var ticketList: [Ticket] =
    [Ticket(id: 0,
            title: "마타하리",
            date: Date.now,
            cast: ["노윤", "옥주현"],
            place: "LG이트센터서울 LG SIGNATURE홀",
            seat: ["1", "A", "3", "20"],
            platform: "멜론티켓",
            price: 1300000,
            reviewStatus: true,
            typeList: [[0,1,2], [0,4,5], [1, 2], [1], [1,2],[2,3,4,5]]),
     Ticket(id: 0,
            title: "리지",
            date: Date.now,
            cast: ["이아름솔", "김소향"],
            place: "두산아트센터 연강홀",
            seat: ["1", "-", "1", "349"],
            platform: "인터파크티켓",
            price: 50000,
            reviewStatus: false,
            typeList: [[0,1,2], [0,4,5], [1, 2], [1], [1,2],[2,3,4,5]])]
    
    private let titleView = TitleView(title: StringLiterals.TicketMain.title,
                                       isLeftButtonHidden: true,
                                       isRightButtonHidden: true)
    lazy var ticketCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: ticketFlowLayout
    )
    private let ticketFlowLayout = UICollectionViewFlowLayout()
    lazy var addTicketButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func setStyle() {
        super.setStyle()
        addTicketButton.do {
            $0.setImage(.btnAddTicket, for: .normal)
        }
        
        ticketFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 16.adjustedHeight
            $0.sectionInset = UIEdgeInsets(top: 16, left: 24, bottom: 18, right: 24)
        }
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 75.adjustedHeight
        
        self.view.addSubviews(titleView,
                              ticketCollectionView,
                              addTicketButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        ticketCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        addTicketButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight - 18.adjustedHeight)
            $0.size.equalTo(60)
        }
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setAddTarget() {
        addTicketButton.addTarget(self,
                                  action: #selector(pushAddTicketViewController),
                                  for: .touchUpInside)
    }
    
    private func setCollectionView() {
        ticketCollectionView.delegate = self
        ticketCollectionView.dataSource = self
        ticketCollectionView.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: TicketCollectionViewCell.className)
    }
    
    @objc private func pushAddTicketViewController() {
        let addTicketViewController = AddTicketViewController()
        addTicketViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addTicketViewController, animated: true)
    }

    @objc private func pushToDetail(_ sender: UITapGestureRecognizer) {
        let ticketDetailViewController = TicketDetailViewController()
        
        guard let cell = sender.view as? TicketCollectionViewCell else { return }
        guard let indexPath = ticketCollectionView.indexPath(for: cell) else { return }
        ticketDetailViewController.ticketData = ticketList[indexPath.row]
        
        ticketDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ticketDetailViewController, animated: true)
    }
}

extension TicketViewController: UICollectionViewDelegate { }

extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TicketCollectionViewCell.className,
            for: indexPath) as? TicketCollectionViewCell else { return UICollectionViewCell() }
        cell.configTicketCell(data: ticketList[indexPath.item])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushToDetail(_:)))
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
}

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width - 48
        let ticket = ticketList[indexPath.item]
        
        // 상태값에 따라 높이 다르게 지정
        let itemHeight: CGFloat = ticket.reviewStatus ? 190.adjustedHeight : 120.adjustedHeight


        return  CGSize(width: itemWidth, height: itemHeight)
    }
}
