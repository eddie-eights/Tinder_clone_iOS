
import Foundation

@MainActor // <- メインスレッドで実行させる
class AuthViewModel: ObservableObject {
    private var auth = AuthService.shared
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    
    func register(onComplete: () -> ()) async throws {
        await auth.register(withEmail: email, name: name, password: password, onComplete: onComplete)
        email = ""
        name = ""
        password = ""
    }
}
