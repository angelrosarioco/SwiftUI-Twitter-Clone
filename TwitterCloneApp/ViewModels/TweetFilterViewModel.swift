//
//  TweetFilter.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 1/31/22.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case likes
    case replies
    
    var title: String {
        switch self {
        case .tweets : return "Tweets"
        case .likes : return "Likes"
        case .replies : return "Replies"
        }
    }
}
