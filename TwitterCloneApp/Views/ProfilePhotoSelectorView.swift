//
//  ProfilePhotoSelectorView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State var showImagePicker = false
    @State var image : UIImage?
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        VStack {
            AuthHeaderView(title: "Create your account.",
                           subtitle: "Add a profile photo")
            
            ProfilePhotoButton(showImagePicker: $showImagePicker, image: $image)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $image)
                }
            
            
            
            
            
            
            
            // TODO: FIX PROFILE IMAGE 
            
            
            
            if let image = image {
                Button {
                    viewModel.uploadProfileImage(image)
                } label: {
                    Text("Contine")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemBlue))
                .clipShape(Capsule())
                .padding()
            }

            
            Spacer()
            
            
        }
        .ignoresSafeArea()
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}

struct ProfilePhotoButton: View {
    
    @Binding var showImagePicker : Bool
    @Binding var image : UIImage?
    
    var body: some View {
        Button {
            self.showImagePicker.toggle()
        } label: {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .padding(.top, 44)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            } else {
                ZStack {
                    Circle()
                        
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        
                    
                    
                }
                .frame(width: 180, height: 180)
                .padding(.top, 44)
                .shadow(radius: 3)
                
            }
        }
    }
}
