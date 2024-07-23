//
//  InspectionService.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation
import Combine

protocol InspectionServiceType {
    
    func start() -> AnyPublisher<InspectionResponse,NetworkRequestError>
}

class InspectionService: InspectionServiceType {
    
    let webservice: WebServiceType
    init(webservice: WebServiceType) {
        self.webservice = webservice
    }
    
    func start() -> AnyPublisher<InspectionResponse, NetworkRequestError> {
        webservice.dispatch(InspectionResponse.self, router: .startInpection)
    }
    
    
}


