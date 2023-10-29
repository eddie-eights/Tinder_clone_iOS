//
//  TinderInputField.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/29.
//

import SwiftUI

struct TinderInputField: View {
    
    let imageName: String
    let isSecureField: Bool = false
    
    @State var placeholderText: String
    @Binding var text: String
    
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField{
                    SecureField(text: $text, label: {
                        Text(placeholderText)
                    })
                }else{
                    TextField(text: $text, label: {
                        Text(placeholderText)
                    })
                    .textInputAutocapitalization(.never)
                }
            }
            .padding(4)
            
            Divider()
                .foregroundColor(Color(.darkGray))
        }
        
    }
}

#Preview {
    TinderInputField(imageName: "envelope", placeholderText: "ここに入力", text: .constant(""))
}
