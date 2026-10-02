//  SignupView.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 11/26/25.

import SwiftUI
import ParseSwift

struct SignupView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var isSignedUp  = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle).bold()
                .padding(.top, 40)
            
            TextField("Username", text: $authViewModel.username)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            TextField("Email", text: $authViewModel.email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $authViewModel.password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $authViewModel.passwordConfirmed)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign Up") {
                authViewModel.signup()
                
                if authViewModel.errorMessage.isEmpty {
                    isSignedUp = true
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            if !authViewModel.errorMessage.isEmpty {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Spacer()
        }
        .navigationDestination(isPresented: $isSignedUp) {
            AnimalSearch(authViewModel: authViewModel)
        }
    }
}

    
    
#Preview {
    SignupView(authViewModel: AuthViewModel())
}
