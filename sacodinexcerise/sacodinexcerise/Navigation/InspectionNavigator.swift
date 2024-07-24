//
//  InspectionNavigator.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation
import UIKit
import SwiftUI

class InspectionNavigator: ChildNavigator {
    
    let servicesFactory: ServicesFactory
    var rootNavigator: NavigatorType
    init(rootNavigator: NavigatorType,
         servicesFactory: ServicesFactory) {
        self.rootNavigator = rootNavigator
        self.servicesFactory = servicesFactory
    }
    
    func start() {
        
        let inspectionListViewModel: InspectionListViewModel = InspectionListViewModel(inspectionListType: .drafted, databaseServices: servicesFactory.makeDatabaseServices(), navigator: self)
        
        let inspectionsVc = SAStoryboard.inspection.instantiateViewController(identifier: InspectionListViewController.storyboardID) { coder in
            
            return InspectionListViewController(coder: coder,viewModel: inspectionListViewModel)
        }
        
        rootNavigator.navigationController.pushViewController(inspectionsVc, animated: false)
    }
    func navigate(to destination: Destinations) {
        switch destination {
        case .newInspection:
            let inspectionQaVc: UIHostingController = UIHostingController(rootView: createInspectionDetailsView(inspectionType: .new))
            self.rootNavigator.navigationController.pushViewController(inspectionQaVc, animated: true)
        case .draftedInspection(let inspection):
            let inspectionQaVc: UIHostingController = UIHostingController(rootView: createInspectionDetailsView(inspectionType: .drafted(inspection)))
            self.rootNavigator.navigationController.pushViewController(inspectionQaVc, animated: true)
        case .inspection:
            rootNavigator.navigationController.popViewController(animated: true)
        case .logout:
            servicesFactory.persistantData().clear()
            servicesFactory.makeDatabaseServices().deleteAllInspactions()
            rootNavigator.navigate(to: .logout)
        default:
            fatalError()
        }
    }
    
    func createInspectionDetailsView(inspectionType: InspectionDetailsType) -> InspectionQuestionsDetailsView {
        let inspectionQAVm = InspectioQuestionDetailsViewModel(inspectionType: inspectionType, 
                                                               inspectionService: servicesFactory.makeInspactionServices(), databaseServices:servicesFactory.makeDatabaseServices(),
                                                               inspectionNavigator: self)
        
        let inspectionQAView = InspectionQuestionsDetailsView(viewModel: inspectionQAVm)
        
        return inspectionQAView
    }

}
