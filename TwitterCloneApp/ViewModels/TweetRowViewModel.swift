//
//  TweetRowViewModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet : TweetModel
    private let service = TweetService()
    
    init(tweet: TweetModel) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
    
    func unlikeTweet() {
        service.unLikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
    
    func checkIfUserLikedTweet() {
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike {
                self.tweet.didLike = true
            }
            
        }
    }
}
