//
//  FontLiterals.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

enum FontName: String {
    case SUITSemiBold = "SUIT-SemiBold"
}

enum FontLevel {
    case body_semibold_12
    case body_semibold_15
    case title_semibold_20
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .body_semibold_12, .body_semibold_15, .title_semibold_20:
            return FontName.SUITSemiBold.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .body_semibold_12:
            return 12.adjusted
        case .body_semibold_15:
            return 15.adjusted
        case .title_semibold_20:
            return 20.adjusted
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .body_semibold_12:
            return FontLevel.body_semibold_12.fontSize * 1.4
        case .body_semibold_15:
            return FontLevel.body_semibold_15.fontSize * 1.4
        case .title_semibold_20:
            return FontLevel.title_semibold_20.fontSize * 1.4
        }
    }
}
