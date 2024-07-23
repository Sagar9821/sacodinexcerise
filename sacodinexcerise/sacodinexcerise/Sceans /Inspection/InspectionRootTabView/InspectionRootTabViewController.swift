//
//  InspectionRootTabViewController.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import UIKit

class InspectionRootTabViewController: UITabBarController {

    private(set) var inspectionListNC: UINavigationController!
    
    private let inspectionListViewController: InspectionListViewController
    init(inspectionListViewController: InspectionListViewController) {
        self.inspectionListViewController = inspectionListViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUIElements()
    }
    
    func setupUIElements() {
        navigationController?.isNavigationBarHidden = true
        inspectionListNC = UINavigationController(rootViewController: inspectionListViewController)
        viewControllers = [inspectionListNC ]
        styleTabBar()
    }
    

    private func styleTabBar() {
        
        tabBar.barTintColor = AppColor.Text.oceanBlue
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = AppColor.Text.oceanBlue
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            tabBar.barTintColor = AppColor.Text.oceanBlue
        }
        
        inspectionListNC.tabBarItem = UITabBarItem(title: "Inspection", image: UIImage(systemName: "pencil.line"), tag: 0)
        
        
    }
    
}
