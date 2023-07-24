//
//  Home.swift
//  MetaballExercise
//
//  Created by Константин Лопаткин on 24.07.2023.
//

import SwiftUI

struct Home: View {
    @State var dragOffset: CGSize = .zero
    var body: some View {
        VStack {
            singleMetaBall()
                .preferredColorScheme(.dark)
        }
    }
    
    @ViewBuilder
    func singleMetaBall() -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.5, color: .white))
            context.addFilter(.blur(radius: 40))
            
            context.drawLayer { ctx in
                for index in [1,2] {
                    if let resolved = context.resolveSymbol(id: index) {
                        ctx.draw(resolved, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            }
        } symbols: {
            ball()
                .tag(1)
            ball(offset: dragOffset)
                .tag(2)
        }
        .gesture(
            DragGesture()
                .onChanged({ val in
                    dragOffset = val.translation
                })
                .onEnded({ _ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        dragOffset = .zero
                    }
                })
        )
    }
    
    func ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
