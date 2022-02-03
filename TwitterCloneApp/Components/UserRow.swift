//
//  UserRowView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 1/31/22.
//

import SwiftUI
import Kingfisher


struct UserRow: View {
    let user : UserModel
    
    var body: some View {
        HStack (spacing: 12) {
            KFImage(URL(string: user.profileImageURL))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 58, height: 58)
            
            VStack (alignment: .leading, spacing: 4) {
                Text("@\(user.username)")
                    .font(.subheadline).bold()
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

//struct UserRow_Preview: PreviewProvider {
//    static var previews: some View {
//        UserRow()
//            .previewLayout(.sizeThatFits)
//    }
//}
