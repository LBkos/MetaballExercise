//
//  Home.swift
//  MetaballExercise
//
//  Created by Константин Лопаткин on 24.07.2023.
//

import SwiftUI

struct Home: View {
    @State var degrees: Bool = false
    var degreesAnimation: Animation {
        Animation.linear(duration: 2.5)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            singleMetaBall()
                .rotationEffect(.degrees(degrees ? 0 : 360))
                .animation(degreesAnimation, value: degrees)
                .preferredColorScheme(.dark)
                .ignoresSafeArea()
                .onAppear {
                    degrees.toggle()
                }
        }
    }
    
    @ViewBuilder
    func singleMetaBall() -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.5, color: .white))
            context.addFilter(.blur(radius: 20))

            context.drawLayer { ctx in
                if let resolved = context.resolveSymbol(id: 1) {
                    ctx.draw(resolved, at: CGPoint(
                        x: size.width / 2.8,
                        y: size.height / 2.5))
                }
                
                if let resolved = context.resolveSymbol(id: 2) {
                    ctx.draw(resolved, at: CGPoint(
                        x: size.width / 2.8,
                        y: size.height / 1.7))
                }
                
                if let resolved = context.resolveSymbol(id: 3) {
                    ctx.draw(resolved, at: CGPoint(
                        x: size.width / 2,
                        y: size.height / 2))
                }
                
                if let resolved = context.resolveSymbol(id: 4) {
                    ctx.draw(resolved, at: CGPoint(
                        x: size.width / 1.6,
                        y: size.height / 2.5))
                }
                
                if let resolved = context.resolveSymbol(id: 5) {
                    ctx.draw(resolved, at: CGPoint(
                        x: size.width / 1.6,
                        y: size.height / 1.7))
                }
            }
        } symbols: {
            BallView(offset: CGSize(width: -35, height: -35))
                .tag(1)
            BallView(offset: CGSize(width: -35, height: 35))
                .tag(2)
            BallView(offset: .zero)
                .tag(3)
            BallView(offset: CGSize(width: 35, height:-35))
                .tag(4)
            BallView(offset: CGSize(width: 35, height: 35))
                .tag(5)
        }
    }
    
    func ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 110, height: 110)
            .offset(offset)
            
    }
}

#Preview {
    Home()
}

struct BallView: View {
    @State var offsetChange: Bool = false
    var offsetAnimation: Animation {
        Animation.easeInOut(duration: 2.5)
            .repeatForever(autoreverses: true)
    }
    var offset: CGSize
    
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 110, height: 110)
            .offset(offsetChange ? offset : .zero)
            .animation(offsetAnimation, value: offsetChange)
            .onAppear {
                offsetChange.toggle()
            }
    }
}
#Preview(body: {
    BallView(offset: .zero)
        .preferredColorScheme(.dark)
})
