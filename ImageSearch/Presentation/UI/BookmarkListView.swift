//
//  BookmarkListView.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import SwiftUI

struct BookmarkListView: View {
    @StateObject var viewModel: BookmarkViewModel
    
    var body: some View {
        VStack {
            imageList
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    loadingView
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.keyboard)
            }
        }
    }
    
    private var imageList: some View {
        List {
            ForEach(viewModel.bookmarkList, id: \.imageUrl) { bookmark in
                VStack(alignment: .leading, spacing: 8) {
                    LoadedImageView(
                        image: bookmark.image,
                        viewModel: viewModel,
                        imageLoader: DIContainer.shared.createImageLoader()
                    )
                }
            }
            
        }
        .overlay {
            if viewModel.bookmarkList.isEmpty && !viewModel.isLoading {
                emptyStateView
            }
        }
    }
}

//#Preview {
//    BookmarkListView()
//}
