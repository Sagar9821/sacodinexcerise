//
//  AppEnvironment.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation

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
}
