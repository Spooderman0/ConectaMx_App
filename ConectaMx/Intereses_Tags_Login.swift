//
//  Intereses_Tags_Login.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

// Intereses_Tags_Login.swift

import SwiftUI

struct Intereses_Tags_Login: View {
    let intereses = ["Deporte", "Tecnología", "Música", "Comida", "Arte", "Ciencia"]
    
    @State var seleccionados = Set<String>()
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Título "Selecciona tus Intereses:"
            Text("Selecciona tus Intereses:")
                .font(.title)
                .fontWeight(.bold)
                
            Spacer()
            // Lista de tags
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3), spacing: 20) {
                    ForEach(intereses, id: \.self) { interes in
                        Button(action: {
                            if seleccionados.contains(interes) {
                                seleccionados.remove(interes)
                            } else {
                                seleccionados.insert(interes)
                            }
                        }) {
                            Text(interes)
                                .lineLimit(1) // Asegura que el texto solo ocupa una línea
                                .padding(.all, 10)
                                .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
                                .background(seleccionados.contains(interes) ? Color(hex: "625C87") : Color.gray.opacity(0.2))
                                .foregroundColor(seleccionados.contains(interes) ? .white : .black)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            
            // Botón "Comenzar"
            Button(action: {
                // Acción para comenzar
            }, label: {
                Text("Comenzar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "625C87"))
                    .cornerRadius(10)
            })
            .padding([.leading, .trailing], 20)
            
            // Botón para saltar este paso
            Button(action: {
                // Acción para saltar este paso
            }, label: {
                Text("Saltar este paso")
                    .underline()
                    .font(.footnote)
                    .foregroundColor(Color(hex: "625C87"))
            })
        }
        .padding()
    }
}

struct Intereses_Tags_Login_Previews: PreviewProvider {
    static var previews: some View {
        Intereses_Tags_Login()
    }
}
