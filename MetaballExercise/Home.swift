//
//  Home.swift
//  MetaballExercise
//
//  Created by Константин Лопаткин on 24.07.2023.
//

import SwiftUI

struct Home: View {
    @State var degrees: Bool = false
    @State var offset: Bool = false
    @State var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var degreesAnimation: Animation {
        Animation.linear(duration: 2.5)
            .repeatForever(autoreverses: false)
    }
    var offsetAnimation: Animation {
        Animation.easeInOut(duration: 2)
    }
    
    var body: some View {
        ZStack {
            singleMetaBall()
                .rotationEffect(.degrees(degrees ? 0 : 360))
                .animation(degreesAnimation, value: degrees)
                .animation(offsetAnimation, value: offset)
                .onReceive(timer, perform: { _ in
                    timeRemaining += 1
                    if timeRemaining % 3 == 0 {
                        offset.toggle()
                    }
                })
                .preferredColorScheme(.dark)
                .ignoresSafeArea()
                .onAppear {
                    degrees.toggle()
                    offset.toggle()
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
            ball(offset: CGSize(width: offset ? -40 : 0, height: offset ? -40 : 0))
                .tag(1)
            ball(offset: CGSize(width: offset ? -35 : 0, height: offset ? 35 : 0))
                .tag(2)
            ball()
                .tag(3)
            ball(offset: CGSize(width: offset ? 35 : 0, height: offset ? -35 : 0))
                .tag(4)
            ball(offset: CGSize(width: offset ? 35 : 0, height: offset ? 35 : 0))
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
