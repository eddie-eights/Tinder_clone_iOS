import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession == nil {
            LoginView()
        }else{
            SwipeView()
        }
    }
}

#Preview {
    ContentView()
}
