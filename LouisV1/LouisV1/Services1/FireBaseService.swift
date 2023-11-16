//
//  FireBaseService.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/6/23.
//

import Foundation
import FirebaseAuth


struct FirebaseService {
    
    func createAccount(with email: String, password: String, confirmPassword: String) {

        if password == confirmPassword {
            Auth.auth().createUser(withEmail:email, password: password) { authResult, error in
                print(authResult?.user.email)
            }
            
        } else {
#warning("update to present an alert to user")
        }
        
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
            }
            print(authResult?.user.email!)
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signoutError as NSError {
            print("Error signing out", signoutError)
        }
    }
}
