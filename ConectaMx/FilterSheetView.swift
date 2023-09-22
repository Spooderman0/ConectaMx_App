//
//  FilterSheetView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 20/09/23.
//

import SwiftUI

struct FilterSheetView: View {
    let tags = ["Deporte", "Tecnología", "Música", "Comida", "Arte", "Ciencia"]
    @State var selectedTags = Set<String>()
    
    var body: some View {
        VStack(spacing: 20) {
            // Título "Filtrar por Intereses:"
            Text("Filtrar por Intereses:")
                .font(.title)
                .fontWeight(.bold)
                
            Spacer()
            // Lista de tags
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3), spacing: 20) {
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .lineLimit(1) // Asegura que el texto solo ocupa una línea
                                .padding(.all, 10)
                                .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
                                .background(selectedTags.contains(tag) ? Color(hex: "625C87") : Color.gray.opacity(0.2))
                                .foregroundColor(selectedTags.contains(tag) ? .white : .black)
                                .cornerRadius(15)
                        }
                    }
                }
            }

            
            // Botón "Aplicar Filtros"
            Button(action: {
                // Acción para aplicar filtros
            }, label: {
                Text("Aplicar Filtros")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "625C87"))
                    .cornerRadius(10)
            })
            .padding([.leading, .trailing], 20)
        }
        .padding()
    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheetView()
    }
}

