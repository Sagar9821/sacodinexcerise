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
    func submit(inspection: InspectionResponse) -> AnyPublisher<Empty,NetworkRequestError>
}

class InspectionService: InspectionServiceType {
    
    let webservice: WebServiceType
    init(webservice: WebServiceType) {
        self.webservice = webservice
    }
    
    func start() -> AnyPublisher<InspectionResponse, NetworkRequestError> {
        webservice.dispatch(InspectionResponse.self, router: .startInpection)
    }
    
    func submit(inspection: InspectionResponse) -> AnyPublisher<Empty, NetworkRequestError> {
        webservice.dispatch(Empty.self, router: .submitInspection(inspection))
    }
}


