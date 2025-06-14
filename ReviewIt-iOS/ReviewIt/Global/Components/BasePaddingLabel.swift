//
//  BasePaddingLabel.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

class BasePaddingLabel: UILabel {
    
    var padding = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}
