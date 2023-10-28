//
//  CardView.swift
//  TinderClone
//
//  Created by 福田瑛斗 on 2023/10/28.
//

import SwiftUI

struct SwipeView: View {
    
    let potentialCards: [Card] = Card.mockData
    
    var body: some View {
        VStack{
            if(potentialCards.isEmpty){
                Spacer()
                Text("表示可能なカードがありません")
                Spacer()
            }else{
                ZStack{
                    ForEach(potentialCards){ card in
                        CardView(card: card)
                    }
                }
            }
        }
    }
}


struct CardView: View {
    
    @State var card: Card
    
    // グラデーションのカラーを設定
    let cardGradient = Gradient(
        colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    
    
    var body: some View {
        VStack{
            
            // 画像
            ZStack(alignment: .topLeading){
                // GeometryReader -> 画面のサイズを取得できる
                GeometryReader(content: { geometry in
                    Image(card.user.profileImageUrl ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .foregroundColor(.white)
                })
                
                // 下に文字を表示するため黒のグラデーションを追加
                LinearGradient(
                    gradient: cardGradient, startPoint: .top, endPoint: .bottom)
                
                VStack{
                    Spacer()
                    HStack {
                        Text(card.user.name)
                            .font(.largeTitle)
                            .bold()
                        if let age = card.user.age {
                            Text(String(age))
                                .font(.title)
                        }
                    }
                    .foregroundColor(.white)
                }
                .padding()
            }
            .background(.black)
            .cornerRadius(16)
            .padding(8)
            
            
            // Nope / Like ボタン
            HStack{
                Spacer()
                
                // Nopeボタン
                Button{
                    
                }label: {
                    Image("dismiss_circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(.white)
                }
                
                Spacer()
                
                // Likeボタン
                Button{
                    
                }label: {
                    Image("like_circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(.white)
                }
                
                Spacer()
            }
        }
    }
}


#Preview {
    SwipeView()
}
