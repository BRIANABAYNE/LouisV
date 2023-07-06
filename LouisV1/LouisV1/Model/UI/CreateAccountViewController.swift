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
    
    
    var viewModel: CreateAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        // Sing in
        
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
        
    } // Create
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
