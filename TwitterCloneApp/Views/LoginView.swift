//
//  LoginView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State var isSecure = true
    
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack {
            
            // Header View
            AuthHeaderView(title: "Hello.",
                           subtitle: "Welcome Back")
            
            VStack (spacing: 40) {
                CustomTextField(imageName: "envelope",
                                placeholder: "Email",
                                text: $email,
                                isEmail: true)
                
                CustomTextField(imageName: "lock",
                                placeholder: "Password",
                                text: $password,
                                isSecure: isSecure, showEye: true)
                
                
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            HStack {
                Spacer()
                NavigationLink {
                    
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }

            }
            .padding(.top)
            .padding(.trailing, 24)
            
            Button {
                viewModel.login(withEmail: email,
                                password: password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
                    
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.caption)
                    Text("Sign Up")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(Color(.systemBlue))
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct AuthHeaderView: View {
    
    let title : String
    let subtitle : String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{Spacer()}
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: .bottomRight))
    }
}
