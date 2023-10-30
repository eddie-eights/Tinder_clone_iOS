//
//  RegisterView.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/29.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            VStack{
                BrandingImage()
                Text("Welcome !")
                    .font(.title)
                    .bold()
                    .padding()
                
                VStack(spacing: 32) {
                    TinderInputField(imageName: "envelope", placeholderText: "メールアドレス", text: $viewModel.email)
                    TinderInputField(imageName: "person", placeholderText: "ユーザー名", text: $viewModel.name)
                    TinderInputField(imageName: "lock", placeholderText: "パスワード", text: $viewModel.password)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                
                Button{
                    Task {
                        try await viewModel.register(){
                            
                        }
                    }
                    
                }label: {
                    Text("新規登録")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                
                Spacer()
                
                Button{
                    dismiss()
                }label:{
                    Text("すでに登録されていますか？")
                        .font(.footnote)
                    Text("ログイン")
                        .font(.footnote)
                        .bold()
                }
                .padding(.bottom, 48)
            }
            
            // 新規ユーザー登録処理のあいだ、ローディング画面を表示
            if $viewModel.isLoading.wrappedValue {
                LoadingOverlayView()
            }
        }
        .alert(viewModel.errorEvent.content,
               isPresented: $viewModel.errorEvent.display){
            Button("OK", role: .cancel){}
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}
