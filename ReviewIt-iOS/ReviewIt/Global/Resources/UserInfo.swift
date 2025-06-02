//
//  UserInfo.swift
//  ReviewIt
//
//  Created by 정채은 on 6/2/25.
//

import Foundation

final class UserInfo {
    static let shared = UserInfo()
    
    var name: String = ""
    
    private init() {}
}

func updateUserInfo(_ data: String) {
    var userType = ""
    
    UserInfo.shared.name = data
}

