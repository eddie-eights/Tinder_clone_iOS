import Combine
import Foundation
import PhotosUI
import SwiftUI

@MainActor  // <- UIに関わるためメインスレッドで実行させる
class AuthViewModel: ObservableObject {
    private var auth = AuthService.shared
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var isLoading = AuthService.shared.isLoading
    private var cancellables = Set<AnyCancellable>()
    @Published var errorEvent = AuthService.shared.errorEvent
    @Published var currentUser = AuthService.shared.currentUser
    @Published var signUpFlowActive = AuthService.shared.signUpFlowActive

    // プロフィール画像が選択されたらUIを更新して画面に表示
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await auth.loadImageFromItem(item: selectedImage)
            }
        }
    }
    @Published var profileImage = AuthService.shared.profileImage

    init() {
        auth.signout()
        setupSubscribers()
    }

    //
    func setupSubscribers() {
        // AuthServiceからローディングを取得しviewModelに同期させる
        auth.$isLoading.sink { [weak self] isLoading in
            self?.isLoading = isLoading
        }
        .store(in: &cancellables)

        // AuthServiceからエラーイベントを取得しviewModelに同期させる
        auth.$errorEvent.sink { [weak self] errorEvent in
            self?.errorEvent = errorEvent
        }
        .store(in: &cancellables)

        // AuthServiceから,ユーザーセッションを取得しviewModelに同期させる
        auth.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)

        auth.$signUpFlowActive.sink { [weak self] signUpFlowActive in
            self?.signUpFlowActive = signUpFlowActive
        }
        .store(in: &cancellables)

        auth.$profileImage.sink { [weak self] profileImage in
            self?.profileImage = profileImage
        }
        .store(in: &cancellables)
    }

    func register(onComplete: () -> Void) async throws {
        await auth.register(
            withEmail: email, name: name, password: password, onComplete: onComplete)
        email = ""
        name = ""
        password = ""
    }

    func login() async throws {
        await auth.login(withEmail: email, password: password)
        email = ""
        password = ""
    }

    func skipRegistrationFlow() {
        signUpFlowActive = false
    }
}
