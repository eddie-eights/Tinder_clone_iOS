import PhotosUI
import SwiftUI

struct RegisterImageView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Step 1 of 6")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()

            Text("Hey, \(viewModel.currentUser?.name ?? "")")
                .font(.title)
                .padding()
            Text("画像をアップロード")
                .font(.headline)
                .padding()

            Divider()

            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .padding()
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .frame(
                                width: 100,
                                height: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/
                            )
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .padding()
                    }
                }
            }
            .padding(.vertical, 8)

            NavigationLink {

            } label: {
                Text("次へ")
                    .font(.subheadline)
                    .frame(width: 360, height: 44)
                    .fontWeight(.semibold)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .foregroundColor(.white)

            }
            .padding()

            Button {
                viewModel.skipRegistrationFlow()
                dismiss()
            } label: {
                Text("入力をスキップ")
            }
            .foregroundColor(.gray)

            Spacer()
        }
    }
}

#Preview {
    RegisterImageView()
        .environmentObject(AuthViewModel())
}
