//
//  ImageUploader.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import Firebase
import UIKit

struct ImageLoader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error != nil {
                print("DEBUG: Failed to upload image with error: \(error!.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, _ in
                guard let imageURL = url?.absoluteString else { return  }
                completion(imageURL)
            }
        }
    }
}
