//
//  CreateAccountViewModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/6/23.
//

import Foundation


struct CreateAccountViewModel {
    
    func createAccount(with email: String, password: String, confirmPassword: String) {
     
        FirebaseService().createAccount(with: email, password: password, confirmPassword: confirmPassword)
    }
    

func signIn(with email: String, password: String, confirmPassword: String ) {
    
    if password == confirmPassword {
        FirebaseService().signIn(email: email, password: password)
   
        /// Create an ALERT
        /// Account already exsit
        /// You put in the wrong email
        /// Write a resuable
}
        
    }
} // end of Model
