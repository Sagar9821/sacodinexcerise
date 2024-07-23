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
    
    var rootNavigator: NavigatorType
    init(rootNavigator: NavigatorType) {
        self.rootNavigator = rootNavigator
    }
    
    func start() {
        
        let inspectionListViewModel: InspectionListViewModel = InspectionListViewModel(inspectionService: InspectionService(webservice: WebService()), navigator: self)
        let inspectionsVc = SAStoryboard.inspection.instantiateViewController(identifier: InspectionListViewController.storyboardID) { coder in
            return InspectionListViewController(coder: coder,viewModel: inspectionListViewModel)
        }
        
        rootNavigator.navigationController.pushViewController(inspectionsVc, animated: false)
    }
    func navigate(to destination: Destinations) {
        switch destination {
        case .inspectionQuestions:
            let inspectionQAView = InspectionQuestionsDetailsView(viewModel: InspectioQuestionDetailsViewModel(inspectionService: InspectionService(webservice: WebService()), inspectionNavigator: self))
            let inspectionQaVc = UIHostingController(rootView: inspectionQAView)
            self.rootNavigator.navigationController.pushViewController(inspectionQaVc, animated: true)
        case .inspection:
            rootNavigator.navigationController.popViewController(animated: true)
        default:
            fatalError()
        }
    }
    

}
