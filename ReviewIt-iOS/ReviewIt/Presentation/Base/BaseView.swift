//
//  BaseView.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        
    }
    
    func setLayout() {
        
    }
    
    func setAddTarget() {
        
    }
}
