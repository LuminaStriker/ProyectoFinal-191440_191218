//
//  PixelArtView.swift
//  Pixel Art-Proyecto Final
//
//  Created by alumno on 07/05/25.
//

/*import SwiftUI

struct PixelArtView: View {
    @State private var pixels: [[Color]]
        @State private var currentColor: Color = .blue
        @State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
        @State private var newSize: String = ""
        @State private var gridSize: Int = 16  // Make this @State
        let pixelSize: CGFloat
        
        // Update your init to use the initial gridSize
        init(pixelSize: CGFloat = 15) {
            self.pixelSize = pixelSize
            _pixels = State(initialValue: Array(
                repeating: Array(repeating: .white, count: 16),  // Use the default 16 here
                count: 16
            ))
        }
        
    
    var body: some View {
        VStack {
            // Color picker
            ScrollView(.horizontal) {
                HStack {
                    ForEach([Color.red, .blue, .green, .yellow, .purple, .black, .white, .orange], id: \.self) { color in
                        color
                            .frame(width: 30, height: 30)
                            .overlay(
                                currentColor == color ? RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.primary, lineWidth: 3) : nil
                            )
                            .onTapGesture {
                                currentColor = color
                            }
                    }
                }
                .padding()
                HStack {
                    VStack {
                        ColorPicker("Color personalizado", selection: $currentColor)
                    }
                }
                HStack{
                    Text("Tamaño actual de Grid")
                    Spacer()
                    Text(String(gridSize))
                }
                HStack{
                    Text("Nuevo tamaño")
                    TextField("Insertar nuevo tamaño", text: $newSize)
                    Button("Cambiar") {
                           if let newGridSize = Int(newSize), newGridSize > 0 {
                               gridSize = newGridSize
                               pixels = Array(
                                   repeating: Array(repeating: .white, count: newGridSize),
                                   count: newGridSize
                               )
                           }
                       }
                }
            }
            VStack{
                cuadricula
                Button("Foto") {
                    guard let image = ImageRenderer(content: cuadricula).uiImage else {
                        print ("no sirvio")
                        return
                    }
                    
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }
        .padding()
    }
    
    var cuadricula:some View{
        ScrollView([.horizontal, .vertical]) {
            VStack(spacing: 0) {
                ForEach(0..<gridSize, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<gridSize, id: \.self) { column in
                            pixelView(row: row, column: column)
                        }
                    }
                }
            }
            .border(Color.gray, width: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func pixelView(row: Int, column: Int) -> some View {
        Rectangle()
            .fill(pixels[row][column])
            .frame(width: pixelSize, height: pixelSize)
            .border(Color.gray.opacity(0.2), width: 0.5)
            .onTapGesture {
                pixels[row][column] = currentColor
            }
            // Add drag gesture for continuous drawing
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        pixels[row][column] = currentColor
                    }
            )
    }
}

#Preview {
    PixelArtView()
}
*/
