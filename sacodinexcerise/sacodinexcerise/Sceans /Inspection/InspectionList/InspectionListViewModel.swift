//
//  InspectionListViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation
import Combine

protocol InspectionListViewModelType {
    var inspectionListResult: PassthroughSubject<Inspection, NetworkRequestError> { get }
    func loadInspections()

    func numberOfInspections() -> Int
    func inspectionAt( _ index: Int) -> Inspection
}

class InspectionListViewModel: InspectionListViewModelType {
    
    
    var arrayInspections: [Inspection] = []
    
    
    var inspectionListResult = PassthroughSubject<Inspection, NetworkRequestError>()
    
    private var cancellables: Set<AnyCancellable> = []
    private var inspectionService: InspectionServiceType
    private var navigator: ChildNavigator
    init(inspectionService: InspectionServiceType, navigator: ChildNavigator) {
        self.inspectionService = inspectionService
        self.navigator = navigator
    }
    
    func loadInspections() {
        inspectionService.start().sink { [weak self] complition in
            switch complition {
            case .finished:
                print("Inspection Received")
            case .failure(let error):
                self?.inspectionListResult.send(completion: .failure(error))

            }
        } receiveValue: { [weak self] inspectionData in            
            self?.arrayInspections.removeAll()
            self?.arrayInspections.append(inspectionData.inspection)
            self?.inspectionListResult.send(inspectionData.inspection)
        }.store(in: &cancellables)

    }
}
extension InspectionListViewModel {
    func numberOfInspections() -> Int {
        return arrayInspections.count
    }
    
    func inspectionAt( _ index: Int) -> Inspection {
        return arrayInspections[index]
    }
}
