//  AuthenticationManager.swift
//  Find My Resource
//  Created by Nitsa Saint Fort, Sebastian Torres, Veljko Stojanovic, Annette Perez, Musab Hafez on 3/19/26.
//

import Combine
import Foundation
import FirebaseAuth // <-- Import Firebase Auth


class AuthViewModel: ObservableObject {
 
    


    var user: User?

  
    let isMocked: Bool = false
 
    var isSignedIn: Bool = false

    
    
    private var handle: AuthStateDidChangeListenerHandle?

    deinit {
         if let handle = handle {
             Auth.auth().removeStateDidChangeListener(handle)
         }
     }
    
    
    // https://firebase.google.com/docs/auth/ios/start#sign_up_new_users
    func signUp(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
            
                self.user = authResult.user
        } catch {
            print(error)
        }
    }
}

    // https://firebase.google.com/docs/auth/ios/start#sign_in_existing_users
    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                self.user = authResult.user
                } catch {
                    print(error)
        }
    }
}


    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print(error)
        }
    }
}
