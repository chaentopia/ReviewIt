//
//  FilterBottomSheetViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import UIKit

import SnapKit
import Then

final class FilterBottomSheetViewController: BaseViewController {
    
    var num = 0
    var itemNum = 0
    var selectedTagIndices: [[Int]] = Array(repeating: [], count: 6)
    var dismissBottomSheet: (([Int]) -> Void)? // 선택된 애들 인덱스 번호
    let tagView = TagGroupCollectionViewCell()
    let doneButton = UIButton()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissBottomSheet?(selectedTagIndices[num])
    }
    
    override func setStyle() {
        super.setStyle()
        tagView.do {
            $0.tagCollectionView.isScrollEnabled = true
            $0.configCell(data: num, selectedIndices: selectedTagIndices[num])
            $0.tagList = typeList[num]
            $0.filterOnTap = { [weak self] tagIndex in
                self?.itemNum = tagIndex
                
                guard let self else { return }
                var selected = self.selectedTagIndices[num]
                if selected.contains(tagIndex) {
                    selected.removeAll { $0 == tagIndex }
                } else {
                    selected.append(tagIndex)
                }
                self.selectedTagIndices[num] = selected
                tagView.configCell(data: num, selectedIndices: selectedTagIndices[num])
            }
        }
        
        doneButton.do {
            $0.setRoundBorder(borderColor: UIColor.mainBlack,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.setTitle(StringLiterals.Home.done, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.setBackgroundColor(.subGray2, for: .normal)
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(tagView,
                              doneButton)
        
        tagView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24.adjustedHeight)
            $0.bottom.equalTo(doneButton.snp.top).offset(24.adjustedHeight)
        }
        
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44.adjustedHeight)
            $0.bottom.equalTo(SizeLiterals.Screen.screenHeight / 2).inset(40.adjustedHeight)
        }
    }
    
    override func setAddTarget() {
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc func doneButtonTapped() {
        // 데이터 넘겨주기
        self.dismiss(animated: true)
    }
}
