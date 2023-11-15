//
//  CreateAccountViewController.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/6/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var enterUserEmailLabel: UITextField!
    @IBOutlet weak var enterUserPasswordLabel: UITextField!
    @IBOutlet weak var enterUserPasswordConfirmLabel: UITextField!
    
    // MARK: - Properties
    var viewModel: CreateAccountViewModel!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
     
        guard let email = enterUserEmailLabel.text,
              let password = enterUserPasswordLabel.text,
              let confirmPassword = enterUserPasswordConfirmLabel.text else { return }
        viewModel.signIn(with: email, password: password, confirmPassword: confirmPassword)
    }
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let email = enterUserEmailLabel.text,
              let password = enterUserPasswordLabel.text,
              let confirmPassword = enterUserPasswordConfirmLabel.text else {return}
        
        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
    }
}
