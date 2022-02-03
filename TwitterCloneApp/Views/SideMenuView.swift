//
//  SideMenuView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 1/31/22.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 32) {
            VStack (alignment: .leading) {
                KFImage(URL(string: "\(viewModel.currentUser?.profileImageURL ?? "")"))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.currentUser?.fullname ?? "")")
                        .font(.headline)
                    Text("@\(viewModel.currentUser?.username ?? "")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                UserStats()
                    .padding(.vertical)
            }
            .padding(.leading)
            
            ForEach(SideMenuViewModel.allCases, id: \.self) { viewModel in
                
                if viewModel == .profile {
                    if let user = self.viewModel.currentUser {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionView(viewModel: viewModel)
                        }
                    }
                    

                } else if viewModel == .logout {
                    Button {
                        self.viewModel.signout()
                    } label: {
                        SideMenuOptionView(viewModel: viewModel)
                    }

                } else {
                    SideMenuOptionView(viewModel: viewModel)
                }
                
                
                
                
            }
            Spacer()
        }
        
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

struct SideMenuOptionView: View {
    var viewModel : SideMenuViewModel
    var body: some View {
        HStack (spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(viewModel.title)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}
