import Firebase
import FirebaseFirestoreSwift
import Foundation
import PhotosUI
import SwiftUI

class AuthService {
    static let shared = AuthService()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorEvent = TinderError(content: "", display: false)
    @Published var signUpFlowActive = false
    @Published var profileImage: Image?
    private var uiImage: UIImage?

    init() {
        Task {
            try await fetchUser()
        }
    }

    // ユーザー新規登録
    @MainActor
    func register(withEmail email: String, name: String, password: String, onComplete: () -> Void)
        async
    {
        isLoading = true
        do {
            // FireBase認証でユーザーを作成し認証情報を呼び出す
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user

            // FireStoreが保存できるデータにエンコード
            let uid = result.user.uid
            let user = User(id: uid, email: email, name: name)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else {
                isLoading = false
                return
            }

            // FireStoreにユーザー情報を保存
            try? await Firestore.firestore().collection(COLLECTION_USER).document(user.id).setData(
                encodedUser)
            self.currentUser = user
            signUpFlowActive = true
            onComplete()

        } catch {
            print("DEBUG: ユーザー作成に失敗しました。 error: \(error.localizedDescription)")
            errorEvent = TinderError(content: error.localizedDescription)
            signout()
        }
        isLoading = false
    }

    func signout() {
        userSession = nil
        currentUser = nil
        try? Auth.auth().signOut()
    }

    // ユーザーログイン
    @MainActor
    func login(withEmail email: String, password: String) async {
        isLoading = true
        do {
            // FireBase認証でユーザーログインを実行
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user

            try await fetchUser()

        } catch {
            print("DEBUG: ログインに失敗しました。 error: \(error.localizedDescription)")
            errorEvent = TinderError(content: error.localizedDescription)
            signout()
        }
        isLoading = false
    }

    // ユーザー情報を取得
    @MainActor
    func fetchUser() async throws {
        userSession = Auth.auth().currentUser
        guard let uid = self.userSession?.uid else { return }
        currentUser = try await UserService.fetchUser(withUid: uid)
    }

    // プロフィール画像をアップロード
    func loadImageFromItem(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }

}
