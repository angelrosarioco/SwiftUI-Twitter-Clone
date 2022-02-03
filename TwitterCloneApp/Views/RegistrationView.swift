//
//  RegistrationView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import SwiftUI

struct RegistrationView: View {
    @State var email = ""
    @State var username = ""
    @State var fullname = ""
    @State var password = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel

    var body: some View {
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelectorView(), isActive: $viewModel.didAuthenticateUser) { }
            
            AuthHeaderView(title: "Get Started.",
                           subtitle: "Create your account")
            
            
            VStack (spacing: 40){
                CustomTextField(imageName: "envelope",
                                placeholder: "Email",
                                text: $email,
                                isEmail: true,
                                isSecure: false)
                
                CustomTextField(imageName: "person",
                                placeholder: "Username",
                                text: $username,
                                isEmail: false,
                                isSecure: false)
               
                CustomTextField(imageName: "person",
                                placeholder: "Fullname",
                                text: $fullname,
                                isEmail: false,
                                isSecure: false)
                
                CustomTextField(imageName: "lock",
                                placeholder: "Password",
                                text: $password,
                                isEmail: false,
                                isSecure: true)
            }
            .padding(32)
            
            
            Button {
                viewModel.register(withEmail: email,
                                   password: password,
                                   fullname: fullname,
                                   username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
                    
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            
            
            
            Spacer()
            
            Button {
                dismiss.callAsFunction()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.caption)
                    Text("Sign Up")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)

        }
        .ignoresSafeArea()
        .onAppear {
            self.viewModel.didAuthenticateUser = false
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
