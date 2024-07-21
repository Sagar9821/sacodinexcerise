//
//  OnboardingViewController.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var viewModel: OnboardingViewModelType
    required init?(coder: NSCoder, viewModel: OnboardingViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action Methods
    @IBAction private func didTapOnLogin() {
        viewModel.moveToLogin()
    }
    
    @IBAction private func didTapOnRegister() {
        viewModel.moveToRegister()
    }
}
