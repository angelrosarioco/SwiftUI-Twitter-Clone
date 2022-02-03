//
//  FeedViewModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [TweetModel]()
    let service = TweetService()
    let userService = UserService()
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                self.userService.fetchUser(withUID: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
