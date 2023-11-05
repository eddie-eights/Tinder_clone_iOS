import FirebaseFirestore
import Foundation

struct UserService {

    // FireStoreからユーザー情報を取得
    @MainActor
    static func fetchUser(withUid uid: String) async throws -> User {

        let snapshot = try await Firestore.firestore()
            .collection(COLLECTION_USER).document(uid).getDocument()

        return try snapshot.data(as: User.self)
    }
}
