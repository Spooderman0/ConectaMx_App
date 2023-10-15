//
//  OrgNotificationView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 11/10/23.
//

import SwiftUI

struct OrgNotificationView: View {
    
    @State private var title = "Nombre de la alerta"
    @State private var description = "Agrega tu texto aquí"
    
    var body: some View {
        
        VStack{
            TextEditor(text: $title)
                .bold()
                .frame(height: 40)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black.opacity(0.5), lineWidth: 1))
            
            TextEditor(text: $description)
                .frame(height: 150)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black.opacity(0.5), lineWidth: 1))
            
            Button(action: {
                // Acción del botón
                print("presionado")
            }) {
                HStack(spacing: 10){

                    // Ícono
                    Image(systemName: "plus.app")
                        .font(.title3)
                    // Título
                    Text("Publicar alerta")
                        .font(.title2)

                }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "3D3D4E"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
        .padding()
    }
}

#Preview {
    OrgNotificationView()
}
