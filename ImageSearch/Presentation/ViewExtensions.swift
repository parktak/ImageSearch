//
//  ViewExtensions.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/21/26.
//

import SwiftUI


extension View {
    
    func emptyStateView(_ message: String, systemImageName: String = "magnifyingglass") -> some View {
        VStack(spacing: 16) {
            Image(systemName: systemImageName)
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text(message)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
    
    var loadingView: some View {
        HStack {
            Circle()
                .fill(.gray.opacity(0.8))
                .frame(width: 200, height: 200)
                .overlay {
                    Text("loading...")
                        .foregroundStyle(.red)
                }
                
        }
    }
}
