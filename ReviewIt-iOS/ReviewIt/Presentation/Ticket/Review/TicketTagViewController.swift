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
        }
        
        reviewTagFlowLayout.do {
            $0.minimumLineSpacing = 20
            $0.scrollDirection = .vertical
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
        cell.configCell(data: 1)
        return cell
    }
}
