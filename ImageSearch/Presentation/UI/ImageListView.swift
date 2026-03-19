//
//  ImageListView.swift
//  ImageSearch
//
//  Created by 박탁인 on 3/17/26.
//

import SwiftUI

struct ImageListView: View {
    @StateObject private var viewModel: ImageViewModel
    @State private var searchText = ""
    @State private var searchTask: Task<Void, Never>?
    @FocusState private var endEditing: Bool
    
    init(viewModel: ImageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            searchBar
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
    
    private var searchBar: some View {
        TextField("이미지 검색", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .submitLabel(.search)
            .onChange(of: searchText) { _, _ in
                searchTask?.cancel()
                
                searchTask = Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    
                    guard !Task.isCancelled else { return }
                    performSearch()
                    
                }
            }
            .focused($endEditing)
            .padding()
    }
    
    private var imageList: some View {
        List {
            ForEach(viewModel.imageList, id: \.imageUrl) { image in
                LoadedImageView(image: image, viewModel: viewModel, imageLoader: DIContainer.shared.createImageLoader())
                    .onAppear {
                        if image.imageUrl == viewModel.imageList.last?.imageUrl {
                            loadMore()
                        }
                    }
            }
            
        }
        .overlay {
            if viewModel.imageList.isEmpty && !viewModel.isLoading {
                emptyStateView
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("검색된 이미지가 없습니다")
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
    
    private var loadingView: some View {
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
    private func performSearch() {
        guard !searchText.isEmpty else { return }
        endEditing = false
        viewModel.search(searchText)
    }
    
    private func loadMore() {
        viewModel.loadMore()
    }
}


//#Preview {
//    ImageListView(viewModel: ImageViewModel(repository: ImageRepositoryImpl(dataSource: ImageDataSourceImpl(apiClient: APIClient()))))
//}

