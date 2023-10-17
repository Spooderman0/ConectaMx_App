//
//  Intereses_Tags_Login.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

// Intereses_Tags_Login.swift

import SwiftUI

struct Intereses_Tags_Login: View {
    var tags: [String]
        
    @State var seleccionadosT = Set<String>()
    @State private var navigateToContent = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Selecciona tus Intereses:")
                .font(.title)
                .fontWeight(.bold)
            
            
            Spacer()
            // Lista de tags
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3), spacing: 20) {
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            if seleccionadosT.contains(tag) {
                                seleccionadosT.remove(tag)
                            } else {
                                seleccionadosT.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .lineLimit(1) // Asegura que el texto solo ocupa una línea
                                .padding(.all, 10)
                                .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
                                .background(seleccionadosT.contains(tag) ? Color(hex: "625C87") : Color.gray.opacity(0.2))
                                .foregroundColor(seleccionadosT.contains(tag) ? .white : .black)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            
            NavigationLink(destination: ContentView(selectedT: seleccionadosT), isActive: $navigateToContent) {
                EmptyView()
            }

            
            // Botón "Comenzar"
            Button(action: {
                // Acción para comenzar
                navigateToContent = true
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
            //            Button(action: {
            //                // Acción para saltar este paso
            //            }, label: {
            //                Text("Saltar este paso")
            //                    .underline()
            //                    .font(.footnote)
            //                    .foregroundColor(Color(hex: "625C87"))
            //            })
            //        }
            //        .padding()
            NavigationLink(destination: ContentView(selectedT: seleccionadosT)) {
                Text("Saltar este paso")
                    .underline()
                    .font(.footnote)
                    .foregroundColor(Color(hex: "625C87"))
            }
        }
        .padding(10)
        
    }
}

struct Intereses_Tags_Login_Previews: PreviewProvider {
    static var previews: some View {
        Intereses_Tags_Login(tags: ["autismo", "cancer"])
    }
}
