//
//  Inicio_Sesion.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//


import SwiftUI

struct Inicio_Sesion: View {
    //@StateObject 
    @EnvironmentObject var session: SessionModel
    var tagsModel = TagsModel()
    @State private var navigateToPRV = false
    @State private var navigateToPLV = false
    @State var LL: Bool = false
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
                
                
                NavigationLink(destination: PersonLoginView(), isActive: $navigateToPLV) {
                    EmptyView()
                }

                Button(action: {
                    navigateToPLV = true
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
                NavigationLink(destination: Intereses_Tags_Login(tags: tagsModel.tags, LL: LL)) {
                    Text("Continuar sin Registro")
                        .foregroundColor(Color(hex: "625C87"))
                        .fontWeight(.medium)
                        .underline()
                        .onAppear(){
                            tagsModel.fetchTags()
                        }
                }

                NavigationLink(destination: PersonRegistrationView(), isActive: $navigateToPRV) {
                    EmptyView()
                }
                Button(action: {
                    navigateToPRV = true
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
                
                NavigationLink(destination: InicioOrgs()) {
                    Text("Continuar como Organización")
                        .foregroundColor(Color(hex: "625C87"))
                        .fontWeight(.medium)
                        .underline()
                }
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
