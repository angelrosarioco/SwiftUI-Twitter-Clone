//
//  ProfileView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 1/31/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var viewModel : ProfileViewModel
    @State private var selectFilter: TweetFilterViewModel = .tweets
    @Environment(\.dismiss) var dismiss
    @Namespace var animation
    
    
    
    
    init(user: UserModel) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HeaderView
            
            ActionButtons
            
            UserInfoDetails
            
            TweetFilterBar
            
            TweetView
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(user: UserModel(id: "1", username: "1", fullname: "!", email: "!", profileImageURL: "1"))
//    }
//}



extension ProfileView {
    
    var HeaderView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            VStack {
                
                Button  {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -4)
                }

                KFImage(URL(string: viewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
                
            }
        }
        .frame(height: 96)
    }
    
    var ActionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(.gray, lineWidth: 0.75))
            
            Button {
                
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.75))
                    .foregroundColor(.black)
                
                
            }
            
            
        }
        .padding(.trailing)
    }
    
    var UserInfoDetails: some View {
        VStack (alignment: .leading, spacing: 4) {
            HStack {
                Text(viewModel.user.fullname)
                    .font(.title2).bold()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
                
            }
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Your moms favorite villian")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack (spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("Gotham, NY")
                    
                }
                
                HStack {
                    
                    Image(systemName: "link")
                    
                    Text("www.joker.com")
                }
            }
            .foregroundColor(.gray)
            .font(.caption)
            
            UserStats()
                .padding(.vertical)
            
            
        }
        .padding(.horizontal)
    }
    
    var TweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.self) { item in
                
                VStack {
                    Text(item.title)
                        .fontWeight(selectFilter == item ? .semibold : .regular)
                        .foregroundColor(selectFilter == item ? .black : .gray)
                    if selectFilter == item {
                        Capsule()
                            .fill(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .fill(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectFilter = item
                    }
                }
                
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var TweetView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tweets(forFilter: self.selectFilter)) { tweet in
                    TweetRowView(tweet: tweet)
                        .padding()
                }
            }
        }
    }
    
}


struct UserStats: View {
    var body: some View {
        HStack (spacing: 24) {
            HStack (spacing: 4){
                Text("807").font(.subheadline).bold()
                
                Text("following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack {
                
                Text("6.9M").font(.subheadline).bold()
                
                Text("followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
