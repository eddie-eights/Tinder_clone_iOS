//
//  BrandingImage.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/29.
//

import SwiftUI

struct BrandingImage: View {
    
    var size: CGFloat = 150
    
    var body: some View {
        Image("fire")
            .resizable()
            .frame(width: size, height: size)
    }
}

#Preview {
    BrandingImage()
}
