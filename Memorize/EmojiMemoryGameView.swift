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
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                ForEach(game.cards) {card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {game.choose(card)}
                }
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
        
    }
    
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        
        GeometryReader(content: {geometry in
            
            ZStack {
                
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.corderRadius)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                }
                else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill().foregroundColor(.red)
                }
                
            }
            
        })
        
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let corderRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        
    }
    
}
