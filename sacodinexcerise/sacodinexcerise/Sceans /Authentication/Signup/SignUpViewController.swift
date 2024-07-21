//
//  SignUpViewController.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIElement()
    }
    private func setupUIElement() {
        navigationBar(title: "Register")
        navigationItem.hidesBackButton = false
    }
}
