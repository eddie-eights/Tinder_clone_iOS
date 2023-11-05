import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        if viewModel.currentUser == nil || viewModel.signUpFlowActive {
            LoginView()
        } else {
            SwipeView()
        }
    }
}

#Preview {
    ContentView()
}
