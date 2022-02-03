//
//  TwitterCloneAppApp.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 1/31/22.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneAppApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
