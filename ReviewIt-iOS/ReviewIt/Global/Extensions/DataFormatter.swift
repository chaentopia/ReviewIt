//
//  DataFormatter.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import Foundation

extension DateFormatter {
    static let ticketDisplayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd (E) HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter
    }()
}
