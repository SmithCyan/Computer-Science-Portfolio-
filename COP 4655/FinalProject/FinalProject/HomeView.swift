//  HomeView.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/7/25.

import SwiftUI
import ParseSwift

struct HomeView: View {
    @ObservedObject var viewModel: AuthViewModel
    var body: some View {
        ZStack {
            // Background
            TiledBackground(imageName: "Image")
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                
                VStack(spacing: 20) {
                    Text("Wildlife App")
                        .font(.largeTitle)
                        .bold()
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Spacer()
                    
                    NavigationLink("Don't have an account? Sign up.",
                                   destination:  SignupView(authViewModel: AuthViewModel()))
                }
                .foregroundColor(Color.blue)
                .font(.footnote)
                .padding(.bottom)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Log Out") {
                        viewModel.logout()
                    }
                }
            }
        }
    }
}
