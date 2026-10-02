//  SignUpView.swift
//  Find My Resource
//  Created by Nitsa Saint Fort, Sebastian Torres, Veljko Stojanovic, Annette Perez, Musab Hafez on 3/24/26.

import SwiftUI
import FirebaseCore

struct SignupView: View {
    @ObservedObject var authenticatorModel: AuthViewModel
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmed = ""
    @State private var errorMessage = ""
    @State private var isSignedUp = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle).bold()
                .padding(.top, 40)
            
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $passwordConfirmed)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign Up") {
                if email.isEmpty || password.isEmpty {
                    errorMessage = "Please fill in all fields."
                    return
                }
                
                if password != passwordConfirmed {
                    errorMessage = "Passwords do not match."
                    return
                }
                errorMessage = ""
                authenticatorModel.signUp(email: email, password: password)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Spacer()
        }
        .navigationDestination(isPresented: $isSignedUp) {
            FindMyResourceApp(authViewModel: authenticatorModel)
        }
    }
}

    
    
#Preview {
    SignupView(authenticatorModel: AuthViewModel())
}
