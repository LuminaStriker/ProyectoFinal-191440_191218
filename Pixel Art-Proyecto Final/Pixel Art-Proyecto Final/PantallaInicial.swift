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
                Image(uiImage: #imageLiteral(resourceName: "Pixel-Maker-5-19-2025.png"))
                    .resizable()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
