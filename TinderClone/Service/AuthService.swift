import Foundation
import Firebase
import FirebaseFirestoreSwift


class AuthService {
    static let shared = AuthService()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // ユーザー新規登録
    func register(withEmail email: String, name: String, password: String, onComplete: () -> ()) async {
        do {
            // FireBase認証でユーザーを作成し認証情報を呼び出す
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // FireStoreが保存できるデータにエンコード
            let uid = result.user.uid
            let user = User(id: uid, email: email, name: name)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else {
                return
            }
            
            // FireStoreにユーザー情報を保存
            try? await Firestore.firestore().collection(COLLECTION_USER).document(user.id).setData(encodedUser)
            self.currentUser = user
            
            onComplete()
            
        } catch{
            print("DEBUG: ユーザー作成に失敗しました。 error: \(error.localizedDescription)")
        }
    }
}
