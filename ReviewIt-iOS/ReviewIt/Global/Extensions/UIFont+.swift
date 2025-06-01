//
//  UIFont+.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

extension UIFont {
    static func fontReviewIT(_ fontLevel: FontLevel) -> UIFont {
        guard let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize) else {
            return .systemFont(ofSize: fontLevel.fontSize)
        }
        return font
    }
}
