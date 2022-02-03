//
//  ExplorerView.swift
//  TwitterCloneApp
//
//  Created by Angel Rosario on 1/31/22.
//

import SwiftUI

struct ExplorerView: View {
    @ObservedObject var viewModel = ExplorerViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchableUsers) { user in
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            UserRow(user: user)
                        }

                    }
                }
            }
        }
        .navigationTitle("Explorer")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerView()
    }
}
