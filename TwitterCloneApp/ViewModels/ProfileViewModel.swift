//
//  ProfileViewModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [TweetModel]()
    @Published var likedTweets = [TweetModel]()
    
    let user : UserModel
    private let service = TweetService()
    private let userService = UserService()
    
    init(user : UserModel) {
        self.user = user
        fetchUserTweets()
        fetchLikedTweets()
    }
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [TweetModel] {
        switch filter {
        case .tweets:
            return tweets
        case .likes:
            return likedTweets
        case .replies:
            return tweets
        }
    }
    
    func fetchUserTweets() {
        guard let uid = user.id else { return }
        
        service.fetchTweets(withUID: uid) { tweets in
            self.tweets = tweets
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
    func fetchLikedTweets() {
        guard let uid = user.id else { return }
        
        service.fetchLikedTweets(withUID: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUID: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
        }
        
    
    }
}
