//
//  AnotherAlternativePixelArtViewTest.swift
//  Pixel Art-Proyecto Final
//
//  Created by alumno on 12/05/25.
//

import SwiftUI

extension UIView {
    var screenshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}

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
            VStack {
                // Give the cuadricula an explicit ID based on gridSize
                cuadricula
                    .id("cuadricula-\(gridSize)")
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: ViewSizeKey.self, value: geometry.size)
                        }
                    )
                    .padding(10)
                    .onPreferenceChange(ViewSizeKey.self) { size in
                        // This helps ensure the view is properly sized
                        print("Cuadricula size:", size)
                    }
                
                Button("Foto") {
                    captureScreenshot()
                }
            }
        }
        .padding()
    }
    
    
    private func captureScreenshot() {
        // Create a hosting controller with a fixed frame
        let controller = UIHostingController(
            rootView: cuadricula
                .frame(
                    width: CGFloat(gridSize) * pixelSize,
                    height: CGFloat(gridSize) * pixelSize
                )
        )
        
        // Set the controller's view size
        let size = CGSize(
            width: CGFloat(gridSize) * pixelSize,
            height: CGFloat(gridSize+5) * pixelSize
        )
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = .clear
        
        // Render after a slight delay to ensure layout
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { _ in
                controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
            }
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    struct ViewSizeKey: PreferenceKey {
        static var defaultValue: CGSize = .zero
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
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

