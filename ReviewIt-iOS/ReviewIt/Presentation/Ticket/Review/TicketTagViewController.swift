//
//  TicketTagViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import SnapKit
import Then

final class TicketTagViewController: BaseViewController {
    
    let type1List = ["힐링극", "코미디극", "피폐물", "추리극", "오열극", "생각이 많아지는 극", "로맨스극", "성장극", "실험극", "판타지극"]
    let type2List = ["연출이 좋았음", "독특함" ,"조명이 좋았음", "무난함", "소품이 좋았음", "의상이 좋았음", "아쉬움", "화려함", "심플"]
    let type3List = ["옥주현", "윤소호", "노윤", "윤사봉", "김주호", "그 외"]
    let type4List = ["안정적인 라이브", "중독성 강한 넘버", "잘 안 들림", "음악 타이밍이 좋았음", "감정과 음악이 잘 어우러짐", "밸런스가 아쉬움", "라이브 아쉬움"]
    let type5List = ["감동적이었음", "이해가 잘 됨", "공감됨", "기대 이상", "기대 이하", "뻔함", "어려웠음", "지루했음", "웃겼음"]
    let type6List = ["인생 공연", "재관람 의향 있음", "눈물을 흘렸음", "한 번만 보기 좋음", "다른 캐스팅이 궁금", "무난함", "힐링되었음", "여운이 남음", "아쉬웠음"]
    
    var selectedTagIndices: [[Int]] = Array(repeating: [], count: 6)
    
    let titleView = TitleView(title: StringLiterals.AddTicket.title,
                              isLeftButtonHidden: false,
                              isRightButtonHidden: true)
    let titleLabel = UILabel()
    
    lazy var reviewTagCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: reviewTagFlowLayout
    )
    private let reviewTagFlowLayout = UICollectionViewFlowLayout()
    
    let bottomView = UIView()
    let laterButton = UIButton()
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func setStyle() {
        self.view.backgroundColor = .mainWhite
        
        titleLabel.do {
            $0.text = StringLiterals.AddTag.titleLabel
            $0.font = .fontReviewIT(.title_semibold_20)
            $0.textColor = .mainBlack
        }
        
        reviewTagCollectionView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .mainWhite
            $0.isUserInteractionEnabled = true
        }
        
        reviewTagFlowLayout.do {
            $0.minimumLineSpacing = 20
            $0.scrollDirection = .vertical
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
        
        bottomView.do {
            $0.backgroundColor = .mainWhite
        }
        
        laterButton.do {
            $0.setTitle(StringLiterals.AddTag.laterButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_12)
            $0.setUnderline(forText: StringLiterals.AddTag.laterButton)
        }
        
        nextButton.do {
            $0.setRoundBorder(borderColor: UIColor.mainBlack,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.setTitle(StringLiterals.AddTag.reviewButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.setBackgroundColor(.subGray2, for: .normal)
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleView,
                         titleLabel,
                         reviewTagCollectionView,
                         bottomView)
        
        bottomView.addSubviews(laterButton,
                               nextButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        reviewTagCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(bottomView.snp.top).offset(-21)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(102)
        }
        
        laterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(5)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setCollectionView() {
        reviewTagCollectionView.delegate = self
        reviewTagCollectionView.dataSource = self
        reviewTagCollectionView.register(TagGroupCollectionViewCell.self, forCellWithReuseIdentifier: TagGroupCollectionViewCell.className)

    }

    override func setAddTarget() {
        titleView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        laterButton.addTarget(self, action: #selector(laterButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func laterButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}

extension TicketTagViewController: UICollectionViewDelegate { }

extension TicketTagViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagGroupCollectionViewCell.className,
            for: indexPath) as? TagGroupCollectionViewCell else { return UICollectionViewCell() }
        cell.configCell(data: indexPath.item,
                        selectedIndices: selectedTagIndices[indexPath.item])

        cell.onTagSelected = { [weak self] tagIndex in
            guard let self else { return }
            var selected = self.selectedTagIndices[indexPath.item]
            if selected.contains(tagIndex) {
                selected.removeAll { $0 == tagIndex }
            } else {
                selected.append(tagIndex)
            }
            self.selectedTagIndices[indexPath.item] = selected
            self.reviewTagCollectionView.reloadItems(at: [indexPath]) // 외부 셀 하나만 reload
        }

        switch indexPath.row {
        case 0:
            cell.tagList = type1List
        case 1:
            cell.tagList = type2List
        case 2:
            cell.tagList = type3List
        case 3:
            cell.tagList = type4List
        case 4:
            cell.tagList = type5List
        case 5:
            cell.tagList = type6List
        default:
            break
        }
        return cell
    }
}
