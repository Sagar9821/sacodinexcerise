//
//  DispatchQueue+Extentions.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import Foundation

extension DispatchQueue {
    static func dispatchToMain( complition: @escaping( () -> Void)) {
        if Thread.isMainThread {
            complition()
        } else {
            DispatchQueue.main.async {
                complition()
            }
        }
    }
}
