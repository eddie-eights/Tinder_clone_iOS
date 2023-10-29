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
                
                // ドラッグした時の Nope / Like ラベル
                HStack{
                    Image("like")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .opacity(Double(card.x / 10 - 1))
                    Spacer()
                    Image("nope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .opacity(Double(card.x / 10 * -1 - 1))
                }
            }
            .background(.black)
            .cornerRadius(16)
            .padding(8)
            // ドラックアニメーションを設定
            .offset(x: card.x, y: card.y)
            .rotationEffect(.init(degrees: card.degree))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.default) {
                            card.x = value.translation.width
                            card.y = value.translation.height
                            card.degree = 7 * (value.translation.width > 0 ? 1 : -1 )
                        }
                        withAnimation(
                            .interpolatingSpring(
                                mass: 1, stiffness: 50, damping: 5, initialVelocity: 0)
                        ) {
                            // ドラッグしている場所に応じたスプリングアニメーションの処理
                            switch value.translation.width {
                            case 0...100:
                                card.x = 0
                                card.y = 0
                                card.degree = 0
                            case let x where x > 100:
                                card.x = 1000
                                card.degree = 12
                            case (-100)...(-1):
                                card.x = 0
                                card.y = 0
                                card.degree = 0
                            case let x where x < -100:
                                card.x = -1000
                                card.degree = -12
                            default:
                                card.x = 0
                                card.y = 0
                            }
                        }
                    })
            )
            
            // Nope / Like ボタン
            HStack{
                Spacer()
                
                // Nopeボタン
                Button{
                    withAnimation(
                        .interpolatingSpring(
                            mass: 1, stiffness: 50, damping: 5, initialVelocity: 0
                        )
                    ){
                        card.x = -1000
                        card.degree = -12
                    }
                }label: {
                    Image("dismiss_circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(.white)
                }
                
                Spacer()
                
                // Likeボタン
                Button{
                    withAnimation(
                        .interpolatingSpring(
                            mass: 1, stiffness: 50, damping: 5, initialVelocity: 0
                        )
                    ){
                        card.x = 1000
                        card.degree = 12
                    }
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
