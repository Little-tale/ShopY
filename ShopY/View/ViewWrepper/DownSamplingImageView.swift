//
//  DownSamplingImageView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import SwiftUI
import Kingfisher

struct DownSamplingImageView: View {
    
    let url: URL?
    let size: CGSize
    
    var body: some View {
        KFImage(url)
            .resizable()
            .setProcessor(
                DownsamplingImageProcessor(
                    size: size
                )
            )
            .cacheOriginalImage()
    }
}
