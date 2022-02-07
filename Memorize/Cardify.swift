//
//  Cardify.swift
//  Memorize
//
//  Created by Kürşad Saka on 7.02.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        
        ZStack {
            
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.corderRadius)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }
            else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
            
        }
        
    }
    
    private struct DrawingConstants {
        static let corderRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.65
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
