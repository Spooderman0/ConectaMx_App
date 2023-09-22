//
//  FavoritesView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 20/09/23.
//

import SwiftUI

struct FavoritesView: View {
    let organizaciones = [
        "Organización 1",
        "Organización 2",
        "Organización 3",
        "Organización 4",
        "Organización 5"
    ]
    
    @State private var activePage: ActivePage = .favorites
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                Text("Favoritos:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.bottom, 20)
                
                ScrollView {
                    VStack {
                        ForEach(organizaciones, id: \.self) { organizacion in
                            Button(action: {
                                self.selectedOrganization = organizacion
                                self.showDetails = true
                            }) {
                                OrganizationView(organizationName: organizacion)
                            }
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 20)
                        }
                        .sheet(isPresented: $showDetails) {
                            OrganizationDetailView(organizationName: selectedOrganization)
                        }

                    }
                }
            }
            
            VStack(spacing: 0) {
                
                //Llamar a barra inferior
                Spacer()
                BottomBarView(activePage: $activePage)
            }
            .zIndex(1)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
