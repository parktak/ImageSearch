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
            ImageListView()
                .tabItem {
                    Image(uiImage: .remove)
                    Text("First")
                }
            
            BookmarkListView()
                .tabItem {
                    Image(uiImage: .remove)
                    Text("second")
                }
            
        }
    }
}

//#Preview {
//    ContentView()
//}

