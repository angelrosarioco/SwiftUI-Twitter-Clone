//
//  TweetService.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/2/22.
//

import Firebase
import FirebaseFirestore

struct TweetService {
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = ["uid" : uid,
                    "caption" : caption,
                    "likes" : 0,
                    "timestamp" : Timestamp(date: Date())
        ] as [String : Any]
        Firestore.firestore().collection("tweets")
            .document()
            .setData(data) { error in
                if error != nil {
                    print("DEBUG: Failed to upload tweet with error \(error!.localizedDescription)")
                    completion(false)
                }
                
                print("DEBUG: Did upload a tweet")
                completion(true)
            }
    }
    
    
    func fetchTweets(completion: @escaping([TweetModel]) -> ()) {
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap({try? $0.data(as: TweetModel.self)})
                
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
            }
    }
    
    
    func fetchTweets(withUID uid: String, completion: @escaping([TweetModel]) -> ()) {
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap({try? $0.data(as: TweetModel.self)})
                
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
            }
    }
    
    
    func likeTweet(_ tweet: TweetModel, completion: @escaping() -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes" : tweet.likes + 1]) { _ in
                userLikeRef.document(tweetId).setData([:]) { _ in
                    print("DEBUG: did like tweet. and now we update UI.")
                    completion()
                }
            }
    }
    
    func unLikeTweet(_ tweet: TweetModel, completion: @escaping() -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes" : tweet.likes - 1]) { _ in
                userLikeRef.document(tweetId).delete { _ in
                    completion()
                }
        }
    }
    
    func checkIfUserLikedTweet(_ tweet: TweetModel, completion: @escaping(Bool) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId)
            .getDocument { snapshot, error in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedTweets(withUID uid: String, completion: @escaping([TweetModel]) -> ()) {
        var tweets = [TweetModel]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { document in
                    let tweetId = document.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetId)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: TweetModel.self) else { return }
                            
                            
                            tweets.append(tweet)
                            
                            completion(tweets)
                        }
                }
                
            }
    }
    
}
