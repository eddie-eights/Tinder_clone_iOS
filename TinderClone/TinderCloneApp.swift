import Firebase
import SwiftUI

@main
struct TinderCloneApp: App {
    // アプリケーション全体で使えるようにインスタンス生成
    @StateObject var viewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                // アプリケーション全体で利用可能にする
                .environmentObject(viewModel)
        }
    }
}
