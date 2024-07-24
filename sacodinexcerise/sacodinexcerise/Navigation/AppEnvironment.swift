//
//  AppEnvironment.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
import UIKit

enum AuthStatus {
    case unauthorised
    case authorised
}

struct AppEnvironment {
    
    static var appFlow: UserFlowEntryPoint {
        switch authStatus {
        case .unauthorised:
            return .onboading
        case .authorised:
            return .inspections
        }
    }
    
    fileprivate static var authStatus: AuthStatus {
        guard let _ = UserDefaults.standard.value(forKey: "user") as? Data else {
            return .unauthorised}
        return .authorised
    }
    
    static func makeService() -> ServicesFactory {
        return .init(webService: WebService())
    }
    
    static func configure() {
        AppEnvironment.configureSwiftLoader()
    }
    
    
    fileprivate static func configureSwiftLoader() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
            config.size = 170
            config.backgroundColor = UIColor(red:0.03, green:0.82, blue:0.7, alpha:1)
            config.spinnerColor = .white
            config.titleTextColor = .white
            config.spinnerLineWidth = 2.0
            config.foregroundColor = UIColor.black
            config.foregroundAlpha = 0.5
            
            SwiftLoader.setConfig(config)
    }
}
