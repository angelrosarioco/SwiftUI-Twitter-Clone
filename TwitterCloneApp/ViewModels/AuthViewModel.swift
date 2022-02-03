//
//  AuthViewModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: UserModel?
    
    
    private var tempUserSession : FirebaseAuth.User?
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: User session is \(self.userSession?.uid)")
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("DEBUG: Failed to sign in with error: \(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Logged in user successfully.")
            print("DEBUG: User is \(self.userSession)")
            
            self.fetchUser()
            
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                return
            }
            
            guard let user = result?.user else { return }
            
            self.tempUserSession = user
            
            let data = ["email" : email,
                        "username" : username.lowercased(),
                        "fullname" : fullname]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                self.didAuthenticateUser = true
            }
        }
        
    }
    
    func signout() {
        self.userSession = nil
        
        do {
            try Auth.auth().signOut()
        } catch let error {
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        ImageLoader.uploadImage(image: image) { imageURL in
            guard let uid = self.tempUserSession?.uid else {
                return
            }
            
            Firestore.firestore().collection("users").document(uid)
                .updateData(["profileImageURL" : imageURL]) { error in
                
                    if error != nil {
                        print("DEBUG: \(error!.localizedDescription)")
                        return
                    }
                    
                self.userSession = self.tempUserSession
                    self.fetchUser()
                    print("updated successfully")
        }
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        
        service.fetchUser(withUID: uid) {user in
            self.currentUser = user
        }
    }
    
    
}
