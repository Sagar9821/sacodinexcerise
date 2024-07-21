//
//  LoginViewController.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: LoginViewModelType
    required init?(coder: NSCoder,viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupBindings()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIElement()
    }
    
    private func setupUIElement() {
        navigationBar(title: "Log in")
        navigationItem.hidesBackButton = true
    }
    
    private func setupBindings() {
        // Bind email text field to view model
        emailTextField.textPublisher
            .sink { [weak self] text in
                self?.viewModel.email.send(text)
            }
            .store(in: &cancellables)
        
        // Bind password text field to view model
        passwordTextField.textPublisher
            .sink { [weak self] text in
                self?.viewModel.password.send(text)
            }
            .store(in: &cancellables)
        
        // Observe login result
        viewModel.loginResult
            .sink { [weak self] result in
                switch result {
                case .success(let authResource):
                    print("Login successful: \(authResource)")
                case .failure(let error):
                    print("Login failed with error: \(error)")
                }
            }
            .store(in: &cancellables)
            
    }
    
    // MARK: - Action Methods
    @IBAction private func didTapOnLogin() {
        viewModel.login()
    }
}
