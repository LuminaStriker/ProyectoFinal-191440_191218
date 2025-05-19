//
//  CapasTest.swift
//  Pixel Art-Proyecto Final
//
//  Created by alumno on 5/12/25.
//

import SwiftUI

//Modelo de las capas
struct Layer {
    let id = UUID()
    let name: String
    let backgroundColor: Color
    
    static var layerCounter = 0
    static func assignNextLayerName() -> String{
        layerCounter += 1
        return "Layer \(layerCounter)"
    }
    
    init(backgroundColor: Color, name: String =
         assignNextLayerName()){
        self.backgroundColor = backgroundColor
        self.name = name
    }
}
//Vista modelo
class GraphicsEditor: ObservableObject {
    @Published var layers = [
        Layer(backgroundColor: Color.green.opacity(0.7), name: "Green Card"),
        Layer(backgroundColor: Color.red.opacity(0.7), name: "Red Card"),
        Layer(backgroundColor: Color.blue.opacity(0.7), name: "Blue Card")
        
        
    ]
    
    func moveLayers(fromOffset source: IndexSet, toOffset destination: Int) {
        if let start = source.first?.distance(to: layers.count - 1) {
            var correctedDestination = (layers.count - 1 - destination)
            correctedDestination += (correctedDestination < start) ? 1 : 0
            let removedCard = layers.remove(at: start)
            layers.insert(removedCard, at: correctedDestination)
        }
    }
}

// Vista
struct LayerView: View {
    
    let layer: Layer
    
    @State private var dragOffset: CGSize = .zero
    @State private var lastPosition:CGSize = .zero
    
    
    var body: some View {
        Rectangle()
            .fill(layer.backgroundColor)
            .cornerRadius(20)
            .shadow(radius: 10)
            .frame(width: 300, height: 400)
            .offset(x: lastPosition.width + dragOffset.width, y: lastPosition.height + dragOffset.height)
            .gesture(
                DragGesture()
                
                    .onChanged({ (value) in dragOffset = value.translation
                    }).onEnded({ (value) in 
                        lastPosition.width += value.translation.width
                        lastPosition.height += value.translation.height
                        dragOffset = .zero
                    })
            )
    }
}

struct LayerNavigator: View {
    var layers: Binding<[Layer]>
    var onChange: ((IndexSet, Int) -> Void)?
    
    init(layers: Binding<[Layer]>) {
        self.layers = layers
        UITableView.appearance().isScrollEnabled = false
    }
    
    var body: some View {
        List {
            HStack{
                Text("Capas")
                Spacer()
                Text("*")
            }.font(.custom("Avenir-Light", size: 24))
                .foregroundColor(.white)
                .listRowBackground(Color.blue.opacity(0.7))
            
            ForEach(layers.wrappedValue.reversed(), id: \.id) {
                layer in
                Text("\(layer.name)")
                    .font(.custom("Avenir-Light", size: 20))
            }.onMove(perform:
                        move).listRowBackground(Color.clear)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: CGFloat(layers.wrappedValue.count) * 60, alignment: .center)
        .fixedSize()
        .environment(\.editMode, .constant(.active))
    }
    
    func onChangingLayers(perform OnChange: @escaping (_ source: IndexSet, _ destination: Int) -> Void) -> Self
    {
        var copy = self
        copy.onChange = onChange
        return copy
    }
    
    private func move(fromOffset source: IndexSet, toOffset
                      destination: Int) {
        onChange?(source, destination)
    }
}

struct CapasTest: View {
    
    @ObservedObject var editor = GraphicsEditor()
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            ForEach(editor.layers, id: \.id) { layer in
                LayerView(layer: layer)
                   .onTapGesture(count: 2, perform: {
                        if layer.id != editor.layers.last!.id {
                            if let index = editor.layers
                                .firstIndex(where: {
                                    $0.id == layer.id }) {
                                editor.layers
                                    .move(fromOffsets: IndexSet(integer: index),
                                          toOffset: editor.layers.count)
                            }
                        }
                    })
            }
            
            VStack {
                Spacer()
                LayerNavigator(layers: $editor.layers).onChangingLayers{
                    (IndexSet, destination) in
                    editor.moveLayers(fromOffset: IndexSet, toOffset: destination)
                }
            }
        }.edgesIgnoringSafeArea([.top, .bottom])
    }
}

#Preview {
    CapasTest()
}
