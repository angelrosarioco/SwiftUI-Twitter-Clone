//
//  UserModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserModel: Codable, Identifiable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    let profileImageURL: String
    
    var isCurrentUser : Bool { return Auth.auth().currentUser?.uid == id}
}
