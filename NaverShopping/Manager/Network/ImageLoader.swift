//
//  ImageLoader.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    
    @Published
    var image: Image?
    
    var cancellables = Set<AnyCancellable> ()
    
    func loadImage(from url: URL?) {
        guard let url else { 
            image = nil
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data )}
            .compactMap { $0 }
            .map { Image(uiImage: $0) }
            .receive(on: DispatchQueue.main)
            .sink {[weak self] complite in
                if case .failure = complite {
                    self?.image = nil
                }
            } receiveValue: {[unowned self] img in
                image = img
            }
            .store(in: &cancellables)
    }
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
}

struct CustomLazyImage: View {
    
    @StateObject private
    var imageLoader = ImageLoader()
    
    private
    let imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        content
            .task {
                imageLoader.loadImage(from: imageURL)
            }
    }
    
    private
    var content: some View {
        Group {
            if let image = imageLoader.image {
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
                    .scaleEffect(1.0, anchor: .center)
                    .progressViewStyle(.circular)
                    .tint(.gray)
            }
        }
    }
}
