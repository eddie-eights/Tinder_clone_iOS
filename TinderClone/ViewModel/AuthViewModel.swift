import Foundation
import Combine

@MainActor // <- メインスレッドで実行させる
class AuthViewModel: ObservableObject {
    private var auth = AuthService.shared
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var isLoading = AuthService.shared.isLoading
    private var cancellables = Set<AnyCancellable> ()
    @Published var errorEvent = AuthService.shared.errorEvent
    @Published var userSession = AuthService.shared.userSession
    
    init(){
        setupSubscribers()
    }
    
    //
    func setupSubscribers(){
        // AuthServiceからローディングを取得しviewModelに同期させる
        auth.$isLoading.sink{ [weak self] isLoading in
            self?.isLoading = isLoading
        }
        .store(in: &cancellables)
        
        // AuthServiceからエラーイベントを取得しviewModelに同期させる
        auth.$errorEvent.sink{ [weak self] errorEvent in
            self?.errorEvent = errorEvent
        }
        .store(in: &cancellables)
        
        // AuthServiceから,ユーザーセッションを取得しviewModelに同期させる
        auth.$userSession.sink{ [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    }
    
    func register(onComplete: () -> ()) async throws {
        await auth.register(withEmail: email, name: name, password: password, onComplete: onComplete)
        email = ""
        name = ""
        password = ""
    }
    
    func login() async throws {
        await auth.login(withEmail: email, password: password )
        email = ""
        password = ""
    }
}
