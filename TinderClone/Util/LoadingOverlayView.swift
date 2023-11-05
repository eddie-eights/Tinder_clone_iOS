//
//  LoadingOverlayView.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/31.
//

import SwiftUI

struct LoadingOverlayView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            Spacer()
            ProgressView()
            Spacer()
        }
        .background(Color.black.opacity(0.25))
    }
}

#Preview {
    LoadingOverlayView()
}
