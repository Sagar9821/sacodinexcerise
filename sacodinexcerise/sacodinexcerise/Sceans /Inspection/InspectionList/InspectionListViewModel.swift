//
//  InspectionListViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation
import Combine

enum InspectionSelectedSegement: Int {
    case drafted = 0
    case completed = 1
}

protocol InspectionListViewModelType {
    var inspectionListType: CurrentValueSubject<InspectionSelectedSegement, Never> { get }
    
    var inspectionListResult: PassthroughSubject<[StoreInspection], NetworkRequestError> { get }
    func loadInspections(type: InspectionSelectedSegement)
    
    func numberOfInspections() -> Int
    func inspectionAt( _ index: Int) -> StoreInspection
    
    func moveToInspectionDetails(index: Int)
    func moveToNewInspection()
    
    func logout()
}

class InspectionListViewModel: InspectionListViewModelType {
    var inspectionListType: CurrentValueSubject<InspectionSelectedSegement, Never>
    
    
    
    var arrayInspections: [StoreInspection] = []
    
    
    var inspectionListResult = PassthroughSubject<[StoreInspection], NetworkRequestError>()
    
    private var cancellables: Set<AnyCancellable> = []
    private var databaseServices: DatabaseServicesType
    private var navigator: ChildNavigator
    init(inspectionListType: InspectionSelectedSegement,
         databaseServices: DatabaseServicesType,
         navigator: ChildNavigator) {
        self.inspectionListType = CurrentValueSubject<InspectionSelectedSegement, Never>(InspectionSelectedSegement.drafted)
        self.databaseServices = databaseServices
        self.navigator = navigator
        setupBinding()
    }
    
    func setupBinding() {
        self.inspectionListType.sink { _ in } receiveValue: { [weak self] selectedListType in
            switch selectedListType {
            case .completed:
                self?.loadInspections(type: .completed)
            case .drafted:
                self?.loadInspections(type: .drafted)
            }
        }.store(in: &cancellables)
        
    }
    
    func loadInspections(type: InspectionSelectedSegement) {
        self.arrayInspections.removeAll()
        switch type {
        case .drafted:
            let draftedInspections = databaseServices.getDraftedInspection()
            self.arrayInspections.append(contentsOf: draftedInspections)
            self.inspectionListResult.send(draftedInspections)
        case .completed:
            let completedInspection = databaseServices.getCompletedInspection()
            self.arrayInspections.append(contentsOf: completedInspection)
            self.inspectionListResult.send(completedInspection)
        }
    }
}
extension InspectionListViewModel {
    func numberOfInspections() -> Int {
        return arrayInspections.count
    }
    
    func inspectionAt( _ index: Int) -> StoreInspection {
        return arrayInspections[index]
    }
}

extension InspectionListViewModel {
    func moveToInspectionDetails(index: Int) {
        do {
            let inspectionDetails = try JSONDecoder().decode(Inspection.self, from: arrayInspections[index].data)
            navigator.navigate(to: .draftedInspection(InspectionResponse(inspection: inspectionDetails)))
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func moveToNewInspection() {
        navigator.navigate(to: .newInspection)
    }
    
    func logout() {
        navigator.navigate(to: .logout)
    }
}
