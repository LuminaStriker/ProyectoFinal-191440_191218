//
//  RenderTest.swift
//  Pixel Art-Proyecto Final
//
//  Created by alumno on 5/9/25.
//

import SwiftUI

struct RenderTest: View {

    var body: some View {
        VStack{
            miVista
            
            Button("Foto") {
                guard let image = ImageRenderer(content: miVista).uiImage else {
                    return
                }
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    
    var miVista: some View {
        VStack{
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Pinshi happy")
        }
        .padding()
        .background(Color.indigo)
    }
}

struct ContentRender: PreviewProvider{
    static var previews: some View{
        RenderTest()
    }
}

