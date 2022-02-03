//
//  NewTweetView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewModel()
    
    @State private var caption = ""
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    viewModel.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    
                }
            }
            .padding()
            HStack (alignment: .top) {
                if let user = authViewModel.currentUser {
                    
                    KFImage(URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 68, height: 68)
                }
                TextArea("What's happening", text: $caption)
                
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadTweet) { success in
            if success {
                dismiss.callAsFunction()
            }
        }
    }
}

//struct NewTweetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTweetView()
//    }
//}
