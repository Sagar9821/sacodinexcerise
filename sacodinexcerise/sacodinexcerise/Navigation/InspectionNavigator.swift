//
//  InspectionNavigator.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation
import UIKit

class InspectionNavigator: ChildNavigator {
    
    var rootNavigator: NavigatorType
    init(rootNavigator: NavigatorType) {
        self.rootNavigator = rootNavigator
    }
    
    func start() {
        rootNavigator.navigationController.isNavigationBarHidden = true
        rootNavigator.navigationController.pushViewController(rootTabView(), animated: false)
    }
    func navigate(to destination: Destinations) {
        switch destination {
        case .inspection:
            break;
        default:
            fatalError()
        }
    }
    
    func rootTabView() -> InspectionRootTabViewController {
     
        let inspectionListViewModel: InspectionListViewModel = InspectionListViewModel(inspectionService: InspectionService(webservice: WebService()), navigator: self)
        let inspectionsVc = SAStoryboard.inspection.instantiateViewController(identifier: InspectionListViewController.storyboardID) { coder in
            return InspectionListViewController(coder: coder,viewModel: inspectionListViewModel)
        }
        
        let inspectionRootTabVc = InspectionRootTabViewController(inspectionListViewController: inspectionsVc)
        return inspectionRootTabVc
    }
}
