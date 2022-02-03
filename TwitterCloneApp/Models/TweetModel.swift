//
//  TweetModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Firebase
import FirebaseFirestoreSwift

struct TweetModel: Codable, Identifiable {
    @DocumentID var id: String?
    var caption: String
    var timestamp : Timestamp
    var uid : String
    var likes : Int
    
    var user : UserModel?
    var didLike : Bool? = false
}
