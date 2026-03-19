//
//  ImageView.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/18/26.
//

import SwiftUI


struct LoadedImageView: View {
    let image: ImageData
    @ObservedObject var viewModel: ImageViewModel
    @StateObject var imageLoader: ImageLoader
    
    var body: some View {
        // 썸네일 이미지
        Group {
            if let loadedImage = imageLoader.image {
                ZStack {
                    Image(uiImage: loadedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .topTrailing) {
                            
                            Button {
                                viewModel.toggleBookmark(image)
                            } label: {
                                Image(systemName: image.isBookmark ? "star.fill" : "star")
                                    .foregroundColor(image.isBookmark ? .yellow : .gray)
                                    
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 5)
                            .padding(.trailing, 5)
                            
                        }
                }
                
                
            } else if imageLoader.isLoading {
                ProgressView()
                    .aspectRatio(CGFloat(image.width) / CGFloat(image.height), contentMode: .fit)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .aspectRatio(CGFloat(image.width) / CGFloat(image.height), contentMode: .fit)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    }
            }
        }
        .task(id: self.image.imageUrl) {
            imageLoader.fetchImage(self.image.imageUrl)
        }
        
    }
    
}
