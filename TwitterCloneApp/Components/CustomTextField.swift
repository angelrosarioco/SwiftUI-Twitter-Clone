//
//  CustomTextField.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 2/1/22.
//

import SwiftUI

struct CustomTextField: View {
    let imageName : String
    let placeholder : String
    @Binding var text : String
    var isEmail : Bool? = false
    @State var isSecure : Bool? = false
    var showEye : Bool? = false
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecure! {
                    SecureField(placeholder, text: $text)
                    
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(isEmail! ? .emailAddress : .default)
                }
                
                if showEye! {
                    if isSecure! {
                        Image(systemName: "eye")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(.darkGray))
                            .onTapGesture {
                                self.isSecure!.toggle()
                            }
                    } else {
                        Image(systemName: "eye.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(.darkGray))
                            .onTapGesture {
                                self.isSecure!.toggle()
                            }
                    }
                }
            }
            Divider()
                .background(Color(.darkGray))
            
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(imageName: "envelope", placeholder: "Email", text: .constant(""))
    }
}
