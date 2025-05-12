//
//  ContentView.swift
//  Pixel Art-Proyecto Final
//
//  Created by alumno on 07/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .fill(.red)
                .onTapGesture { location in
                    print("Tapped at \(location)")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
