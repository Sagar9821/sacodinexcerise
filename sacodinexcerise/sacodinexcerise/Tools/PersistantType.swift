//
//  PersistantType.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
protocol PersistentDataType {
    var userDetails: AuthenticationResource? { get set }
}

class PersistentData : PersistentDataType {
    
    var userDetails: AuthenticationResource? {
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.setValue(data, forKey: "user")
            } catch {
                print("[error] saving user details \(error.localizedDescription)")
            }
        }
        
        get {
            do {
                guard let data = UserDefaults.standard.data(forKey: "user") else { return nil }
                let user = try JSONDecoder().decode(AuthenticationResource.self, from: data)
            } catch {
                print("[error] get user details \(error.localizedDescription)")
            }
            return nil
        }
    }
}
