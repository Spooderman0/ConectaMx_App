//
//  OrganizationBottomBarView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 28/09/23.
//

import SwiftUI

enum OrgActivePage {
    case home
    case messages
    case profile
}

struct OrgBottomBarView: View {
    @Binding var activePage: OrgActivePage
    
    var body: some View {
        VStack{ // Agrega
            Spacer()
            HStack {
                Button(action: {
                    activePage = .home
                }) {
                    Image(systemName: activePage == .home ? "house.fill" : "house")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .opacity(activePage == .home ? 1.0 : 0.5)
                }
                
                Spacer()
                
                
//                Button(action: {
//                    activePage = .messages
//                }) {
//                    Image(systemName: activePage == .messages ? "message.fill" : "message")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.white)
//                        .opacity(activePage == .messages ? 1.0 : 0.5)
//                }
                
                Spacer()
                
                Button(action: {
                    activePage = .profile
                }) {
                    Image(systemName: activePage == .profile ? "person.fill" : "person")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .opacity(activePage == .profile ? 1.0 : 0.5)
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            .background(Color(hex: "3D3D4E"))
            .cornerRadius(60)
            .shadow(radius: 15)
            .padding(.horizontal, 15)
            .padding(.bottom, 3) // El espacio entre la barra y el límite inf
        }
        .edgesIgnoringSafeArea(.bottom)  // Ignora el área segura en la parte inferior

    }
}


struct OrgBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        OrgBottomBarView(activePage: .constant(.home))
    }
}
