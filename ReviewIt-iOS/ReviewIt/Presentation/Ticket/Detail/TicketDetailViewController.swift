//
//  TicketDetailViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketDetailViewController: BaseViewController {
    
    var ticketData: Ticket = Ticket(id: 0,
                                    title: "마타하리",
                                    date: Date.now,
                                    cast: ["노윤", "옥주현"],
                                    place: "LG아트센터서울 LG SIGNATURE홀",
                                    seat: ["1", "A", "3", "20"],
                                    platform: "멜론티켓",
                                    price: 130000,
                                    reviewStatus: true,
                                    typeList: [[0,1,2], [0,4,5], [1, 2], [1], [1,2],[2,3,4,5]])
    
    private let titleView = TitleView(title: StringLiterals.TicketDetail.title,
                                       isLeftButtonHidden: false,
                                       isRightButtonHidden: false)
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let ticketTitleLabel = TicketDetailLabel()
    let dateLabel = TicketDetailLabel()
    let castLabel = TicketDetailLabel()
    let placeLabel = TicketDetailLabel()
    
    let seatLabel = UILabel()
    let seatStackView = UIStackView()
    let seatFloorLabel = TicketSeatDetailLabel()
    let seatSectionLabel = TicketSeatDetailLabel()
    let seatRowLabel = TicketSeatDetailLabel()
    let seatNumLabel = TicketSeatDetailLabel()
    
    let platformLabel = TicketDetailLabel()
    let priceLabel = TicketDetailLabel()
    
    lazy var reviewTagCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: reviewTagFlowLayout
    )
    private let reviewTagFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func setStyle() {
        self.view.backgroundColor = .mainWhite

        titleLabel.do {
            $0.text = StringLiterals.AddTicket.titleLabel
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
            $0.contentMode = .scaleAspectFit
        }
        
        ticketTitleLabel.do {
            $0.text = ticketData.title
        }
        
        dateLabel.do {
            $0.text = DateFormatter.ticketDisplayFormatter.string(from: ticketData.date)
        }
        
        castLabel.do {
            $0.text = ticketData.cast.joined(separator: ", ")
        }
        
        placeLabel.do {
            $0.text = ticketData.place
        }
        
        seatLabel.do {
            $0.text = StringLiterals.AddTicket.seatLabel
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        seatStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.isUserInteractionEnabled = true
        }
        
        seatFloorLabel.do {
            $0.text = "\(ticketData.seat[0])층"
        }
        
        seatSectionLabel.do {
            $0.text = "\(ticketData.seat[1])구역"
        }
        
        seatRowLabel.do {
            $0.text = "\(ticketData.seat[2])열"
        }
        
        seatNumLabel.do {
            $0.text = "\(ticketData.seat[3])번"
        }
        
        platformLabel.do {
            $0.text = ticketData.platform
        }
        
        priceLabel.do {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "ko_KR")

            if let formattedPrice = formatter.string(from: NSNumber(value: ticketData.price)) {
                let result = "₩\(formattedPrice)"
                $0.text = result
            }
        }
        
        reviewTagCollectionView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .mainWhite
        }
        
        reviewTagFlowLayout.do {
            $0.minimumLineSpacing = 20
            $0.scrollDirection = .vertical
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func setLayout() {
        view.addSubviews(scrollView,
                        titleView)
        
        scrollView.addSubviews(titleLabel,
                               posterImageView,
                               ticketTitleLabel,
                               dateLabel,
                               castLabel,
                               placeLabel,
                               seatLabel,
                               seatStackView,
                               platformLabel,
                               priceLabel,
                               reviewTagCollectionView)
        
        seatStackView.addArrangedSubviews(seatFloorLabel,
                                          seatSectionLabel,
                                          seatRowLabel,
                                          seatNumLabel)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
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
        
        ticketTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(44)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(ticketTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(16)
            $0.leading.equalTo(ticketTitleLabel)
        }
        
        seatStackView.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(8)
            $0.leading.equalTo(ticketTitleLabel)
        }
        
        platformLabel.snp.makeConstraints {
            $0.top.equalTo(seatStackView.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(platformLabel.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(ticketTitleLabel)
            $0.height.equalTo(ticketTitleLabel)
        }
        
        reviewTagCollectionView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(45)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight)
            $0.bottom.equalToSuperview().inset(45)
        }
    }
    
    private func setCollectionView() {
        reviewTagCollectionView.delegate = self
        reviewTagCollectionView.dataSource = self
        reviewTagCollectionView.register(TagGroupDetailCollectionViewCell.self, forCellWithReuseIdentifier: TagGroupDetailCollectionViewCell.className)
    }
    
    override func setAddTarget() {
        titleView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        titleView.rightButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        // 정보 넘기는 로직 추가
        let addTicketViewController = AddTicketViewController()
        self.navigationController?.pushViewController(addTicketViewController, animated: true)
    }
}

extension TicketDetailViewController: UICollectionViewDelegate { }

extension TicketDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let nonEmptyTypeCount = ticketData.typeList.filter { !$0.isEmpty }.count
        return nonEmptyTypeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagGroupDetailCollectionViewCell.className,
            for: indexPath) as? TagGroupDetailCollectionViewCell else { return UICollectionViewCell() }
        cell.configCell(data: indexPath.item,
                        tagList: ticketData.typeList[indexPath.item])
        return cell
    }
}
