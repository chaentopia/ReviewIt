//
//  HomeFilterCollectionViewCell.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import UIKit

import SnapKit
import Then

final class HomeFilterCollectionViewCell: UICollectionViewCell {
    
    var selectedTagIndex: [Int] = []
    var rowNum = 0
    var onTap: (() -> Void)?
    let tagButton = UIButton()
    let titleList = [StringLiterals.Home.type1,
                     StringLiterals.Home.type2,
                     StringLiterals.Home.type3,
                     StringLiterals.Home.type4,
                     StringLiterals.Home.type5,
                     StringLiterals.Home.type6]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        tagButton.do {
            $0.setTitle(StringLiterals.Home.type1, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.setRoundBorder(borderColor: .subGray1,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.setImage(.icDownArrow, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9)
            $0.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    private func setLayout() {
        self.addSubviews(tagButton)
        
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configTagCell(data: Int, isSelected: Bool, selectedTagIndex: [Int]) {
        rowNum = data
        self.isSelected = isSelected
        self.selectedTagIndex = selectedTagIndex
        var tagList: [String] = []
        selectedTagIndex.forEach {
            tagList.append(typeList[data][$0])
        }
        tagButton.setTitle(isSelected ? tagList.joined(separator: ", ") : titleList[data], for: .normal)
        tagButton.setImage(isSelected ? .icDownArrowSelected : .icDownArrow, for: .normal)
        tagButton.setTitleColor(isSelected ? .mainBurgundy : .mainBlack, for: .normal)
        tagButton.setRoundBorder(borderColor: isSelected ? .mainBurgundy : .subGray1,
                                 borderWidth: 1,
                                 cornerRadius: 10)
    }
    
    private func setAddTarget() {
        tagButton.addTarget(self, action: #selector(tagButtonTapped), for: .touchUpInside)
    }
    
    @objc private func tagButtonTapped() {
        configTagCell(data: rowNum, isSelected: isSelected, selectedTagIndex: selectedTagIndex)
        onTap?()
    }
}
