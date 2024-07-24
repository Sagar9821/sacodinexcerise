//
//  AuthenticationFactory.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import Foundation

struct ServicesFactory {
    let webService: WebService
    func makeAuthService(persistantData: PersistentDataType) -> AuthenticationServicesType {
        return AuthenticationServices(webService: webService, persistentData: persistantData)
    }
    
    func makeInspactionServices() -> InspectionServiceType {
        return InspectionService(webservice: webService)
    }
    
    func makeDatabaseServices() -> DatabaseServicesType {
        return DatabaseServices()
    }
    
    func persistantData() -> PersistentDataType {
        return PersistentData()
    }
}
