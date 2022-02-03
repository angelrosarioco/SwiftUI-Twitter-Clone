//
//  UserService.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import Firebase
import FirebaseFirestoreSwift


struct UserService {
    
    
    
    func fetchUser(withUID uid: String, completion: @escaping(UserModel) -> ()) {
        
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: UserModel.self) else { return }
                
                completion(user)
                
            }
        
    }
    
    func fetchUsers(completion: @escaping([UserModel]) -> ()) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let users = documents.compactMap( {try? $0.data(as: UserModel.self) })
                completion(users)
            }
    }
    
}
