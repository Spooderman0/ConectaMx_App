//
//  OrganizationBottomBarView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 28/09/23.
//

import SwiftUI

enum OrgActivePage {
    case home
    case profile
}

struct OrganizationBottomBarView: View {
    @Binding var orgactivePage: OrgActivePage
    
    var body: some View {
        HStack {
            Button(action: {
                orgactivePage = .home
            }) {
                Image(systemName: orgactivePage == .home ? "house.fill" : "house")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(orgactivePage == .home ? 1.0 : 0.5)
            }
            
            Spacer()
            
            
            Button(action: {
                orgactivePage = .profile
            }) {
                Image(systemName: orgactivePage == .profile ? "person.fill" : "person")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(orgactivePage == .profile ? 1.0 : 0.5)
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .background(Color(hex: "625C87"))
        .cornerRadius(20)
        .shadow(radius: 15)
        .padding(.horizontal, 6)
        .padding(.bottom, 0)
    }
}

