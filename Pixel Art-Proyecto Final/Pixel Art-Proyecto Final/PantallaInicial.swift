//
//  PantallaInicial.swift
//  Pixel Art-Proyecto Final
//
//  Created by alumno on 19/05/25.
//

import SwiftUI

struct PantallaInicial: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Pixel Maker")
                    .fontWeight(.bold)
                    .font(.title)
                NavigationLink{
                    PixelArtView()
                } label :{
                    Text("Comienza a crear")
                        .padding(10)
                        .foregroundStyle(Color.black)
                        .background(Color.cyan)
                        .cornerRadius(15)
                        .shadow(color: Color.black, radius: 2, x: 2, y: 2)
                }
            }
        }
    }
}

#Preview {
    PantallaInicial()
}
