//
//  ExplorerViewModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Foundation


class ExplorerViewModel: ObservableObject {
    
    @Published var users = [UserModel]()
    @Published var searchText = ""
    
    var searchableUsers: [UserModel] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter {$0.username.contains(lowercasedQuery) ||
                                $0.fullname.lowercased().contains(lowercasedQuery)
                
            }
        }
    }
    
    let service = UserService()
    
    init() {
        self.fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers() { users in
            self.users = users
        }
    }
}
