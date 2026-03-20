//
//  ContentView.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    let vm = DIContainer.shared.createImageViewModel()
    
    var body: some View {
        TabView {
            ImageListView(viewModel: DIContainer.shared.createImageViewModel())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("이미지 검색")
                }
            
            BookmarkListView(viewModel: DIContainer.shared.createBookmarViewModel())
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("북마크 이미지")
                }
            
        }
    }
}

//#Preview {
//    ContentView()
//}

