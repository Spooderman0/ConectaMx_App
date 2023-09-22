//
//  Inicio_Sesion.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//


import SwiftUI

struct Inicio_Sesion: View {
    
    var body: some View {
        NavigationView{
            VStack(spacing: 30) {
                // Imagen en la parte superior
                Image("logoApp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                // Título
                Text("Inicio de Sesión")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Botón de inicio de sesión
                Button(action: {
                    // Acción para el inicio de sesión
                }, label: {
                    Text("Iniciar Sesión")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "625C87"))
                        .cornerRadius(10)
                        .fontWeight(.semibold)
                })
                .padding([.leading, .trailing], 20)
                
                // Botón para continuar sin registro
                NavigationLink(destination: Intereses_Tags_Login()) {
                    Text("Continuar sin Registro")
                        .foregroundColor(Color(hex: "625C87"))
                        .fontWeight(.medium)
                        .underline()
                }

                
                // Botón para registrarse con número telefónico
                Button(action: {
                    // Acción para registrarse con número telefónico
                }, label: {
                    HStack {
                        Image("iphone_phone_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("Registrarse con teléfono")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "F2F2F2"))
                    .cornerRadius(10)
                })
                .padding([.leading, .trailing], 20)
                
                Spacer()
                
                // Botón para continuar como organización
                Button(action: {
                // Acción para continuar como organización
                }, label: {
                    Text("Continuar como Organización")
                        .foregroundColor(Color(hex: "625C87"))
                        .fontWeight(.medium)
                        .underline()
                })
            }
            .padding()
        }
    }
}

struct Inicio_Sesion_Previews: PreviewProvider {
    static var previews: some View {
        Inicio_Sesion()
    }
}
