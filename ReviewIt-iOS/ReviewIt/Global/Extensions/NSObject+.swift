//
//  NSObject+.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import Foundation

extension NSObject {
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}
