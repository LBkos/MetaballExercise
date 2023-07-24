//
//  ContentView.swift
//  MetaballExercise
//
//  Created by Константин Лопаткин on 24.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
