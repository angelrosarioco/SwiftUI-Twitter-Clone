//
//  UploadTweetViewModel.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var didUploadTweet = false
    
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { success in
            
            if success {
                self.didUploadTweet = true
            } else {
                // show error
            }
        }
    }
}
