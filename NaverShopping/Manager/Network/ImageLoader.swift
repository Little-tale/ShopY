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
                if case .failure(let error) = complite {
                    self?.image = nil
                }
            } receiveValue: {[unowned self] img in
                image = img
            }
            .store(in: &cancellables)


    }
}
