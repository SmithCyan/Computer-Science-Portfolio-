//  LoginView.swift
//  Find My Resource
//  Created by Nitsa Saint Fort, Sebastian Torres, Veljko Stojanovic, Annette Perez, Musab Hafez on 3/24/26.

import SwiftUI
import Combine
import FirebaseCore

struct LoginView: View {
    @ObservedObject var authenticatorModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            // Background
           
            VStack(spacing: 20) {
                
                Text("Find My Resource App")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                if errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button("Login") {
                    if email.isEmpty || password.isEmpty {
                        errorMessage = "Please fill in all fields."
                        return
                    }
                    authenticatorModel.signIn(email:email, password: password)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                Spacer()
                
                NavigationLink("Don't have an account? Sign up.") {
                    SignupView(authenticatorModel: authenticatorModel)
                }
                .padding(.bottom)
            }
            .padding()
        }
    }
}
