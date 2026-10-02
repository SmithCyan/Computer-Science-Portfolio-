//  LoginView.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/6/25.


import SwiftUI
import ParseSwift

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var isSignedUp  = false
    
    var body: some View {
        ZStack {
            // Background
            TiledBackground(imageName: "Image")
            VStack(spacing: 20) {
                
                Text("Wildlife App")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                TextField("Email", text: $authViewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $authViewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                if !authViewModel.errorMessage.isEmpty {
                    Text(authViewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button("Login") {
                    authViewModel.login()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                Text("Nitsa Saint Fort")
                Text("Z23652988")
                
                Spacer()
                
                NavigationLink("Don't have an account? Sign up.") {
                    SignupView(authViewModel: authViewModel)
                }
                .padding(.bottom)
            }
            .padding()
        }
    }
}
