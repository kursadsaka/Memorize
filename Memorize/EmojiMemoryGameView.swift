//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kürşad Saka on 22.01.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) {card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            }
            else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {game.choose(card)}
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
        
    }
    
//    @ViewBuilder
//    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
//        if card.isMatched && !card.isFaceUp {
//            Rectangle().opacity(0)
//        }
//        else {
//            CardView(card: card)
//                .padding(4)
//                .onTapGesture {game.choose(card)}
//        }
//    }
    
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        
        GeometryReader(content: {geometry in
            
            ZStack {
                
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content).font(font(in: geometry.size))
                
            }
            .cardify(isFaceUp: card.isFaceUp)
            
        })
        
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.65
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        
    }
    
}
