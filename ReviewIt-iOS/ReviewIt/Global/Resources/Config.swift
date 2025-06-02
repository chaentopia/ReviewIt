//
//  Config.swift
//  CONTACTO-iOS
//
//  Created by 정채은 on 11/9/24.
//

import Foundation

enum Config {
    enum Keys {
        enum Plist {
            static let kakaoAppKey = "KAKAO_APP_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    static let kakaoAppKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoAppKey] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
}
