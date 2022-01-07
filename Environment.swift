//
//  Environment.swift
//  ByteCoin
//
//  Created by Eetu Hernesniemi on 7.1.2022.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let ApiKey = "API_KEY"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    
    static let ApiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.ApiKey] as? String else {
            fatalError("API Key is not set in plist for this environment")
        }
        if apiKey == "" {
            fatalError("API Key has not been defined")
        }
        return apiKey
    }()
}
