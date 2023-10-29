//
//  LoginView.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/29.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack{
            NavigationLink {
                RegisterView()
                    .navigationBarHidden(true)
            } label: {
                Text("新規登録")
            }
        }
        
    }
}

#Preview {
    LoginView()
}
