import SwiftUI

struct LoginView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BrandingImage()
                    Text("おかえりなさい！")
                        .font(.largeTitle)
                        .padding()

                    VStack(spacing: 32) {
                        TinderInputField(
                            imageName: "envelope", placeholderText: "メールアドレス",
                            text: $viewModel.email)
                        TinderInputField(
                            imageName: "lock", placeholderText: "パスワード", text: $viewModel.password)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)

                    Button {
                        Task {
                            try await viewModel.login()
                        }

                    } label: {
                        Text("ログイン")
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

                    NavigationLink {
                        RegisterView()
                            .navigationBarHidden(true)
                    } label: {
                        Text("アカウントをお持ちではないですか？")
                            .font(.footnote)
                        Text("新規登録")
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
            .alert(
                viewModel.errorEvent.content,
                isPresented: $viewModel.errorEvent.display
            ) {
                Button("OK", role: .cancel) {}
            }
        }

    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
