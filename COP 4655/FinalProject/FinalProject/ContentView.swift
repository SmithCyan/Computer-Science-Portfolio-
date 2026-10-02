//  ContentView.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 11/15/25.
// Wildlife App

import SwiftUI
import Combine
import ParseSwift

class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirmed = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false

    func login() {
        errorMessage = ""
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }

        User.login(username: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Logged in as", user.username ?? "(no username)")
                    self.isLoggedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signup() {
        errorMessage = ""
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !passwordConfirmed.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        guard password == passwordConfirmed else {
            errorMessage = "Passwords do not match."
            return
        }

        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password

        newUser.signup { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Signed up:", user.username ?? "(none)")
                    self.isLoggedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func logout() {
        User.logout { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Logged out")
                    self.isLoggedIn = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

    struct ContentView: View {
        @StateObject private var authViewModel = AuthViewModel()
        
        var body: some View {
            NavigationStack {
                if authViewModel.isLoggedIn {
                    HomeView(viewModel: authViewModel)
                } else {
                    LoginView(authViewModel: authViewModel)
                }
            }
        }
    }
    
    #Preview {
        ContentView()
    }

