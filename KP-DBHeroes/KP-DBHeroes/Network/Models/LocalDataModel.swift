//
//  LocalDataModel.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 3/2/24.
//

import Foundation

private enum Constants {
    static let tokenKey = "KCToken"
}

final class LocalDataModel {
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constants.tokenKey)
    }
    
    static func save(token: String) {
        userDefaults.set(token, forKey: Constants.tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: Constants.tokenKey)
    }
}
