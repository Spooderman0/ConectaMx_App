//
//  InicioOrgs.swift
//  ConectaMx
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct InicioOrgs: View {
        @State private var navigateToORV = false
        @State private var navigateToOLV = false
        var body: some View {
            NavigationView{
                VStack(spacing: 30) {
                    
                    Image("logoApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    
                    Text("Organicaciónes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    
                    NavigationLink(destination: OrgLoginView(), isActive: $navigateToOLV) {
                        EmptyView()
                    }

                    Button(action: {
                        navigateToOLV = true
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
                    
       

                    NavigationLink(destination: OrganizationRegistrationView(), isActive: $navigateToORV) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        navigateToORV = true
                        
                    }, label: {
                        HStack {
                            Text("Registrarse")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "F2F2F2"))
                        .cornerRadius(10)
                    })
                    .padding([.leading, .trailing], 20)
                    
                    Spacer()
                          
                }
                .padding()
            }
        }
    }

    struct InicioOrgsPreviews: PreviewProvider {
        static var previews: some View {
            Inicio_Sesion()
        }
    }
