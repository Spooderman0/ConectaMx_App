//
//  Home.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI



struct HomeView: View {
    let organizaciones = [
        "Organización 1",
        "Organización 2",
        "Organización 3",
        "Organización 4",
        "Organización 5"
    ]
    
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    @State private var activePage: ActivePage = .home
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                Text("Organizaciones:")
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

struct OrganizationView: View {
    var organizationName: String
    
    var body: some View {
        ZStack {
            Image("Org_Mock")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            Color.black.opacity(0.5)
            
            VStack {
                Text(organizationName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Lorem ipsum...")
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 5)
                
                HStack(spacing: 30) {
                    Text("Tag1")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(hex: "625C87"))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    
                    Text("Tag2")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(hex: "625C87"))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    
                    Text("Tag3")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(hex: "625C87"))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .padding([.top, .bottom], 5)
            }
            .padding()
        }
    }
}

struct OrganizationDetailView: View {
    var organizationName: String
    
    var body: some View {
        ScrollView {
            Text("Organización")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                .padding(.top, 10)
            
            Text("Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .padding(.bottom, 10)
            
            HStack {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(hex: "625C87"))
                        Text("Haz Cita")
                            .foregroundStyle(Color(hex: "625C87"))
                        
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "message")
                            .foregroundColor(Color(hex: "625C87"))
                        Text("Contáctanos")
                            .foregroundStyle(Color(hex: "625C87"))
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "heart")
                        .foregroundColor(Color(hex: "625C87"))
                }
            }
            .padding(.bottom, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<4) { _ in
                        Image("Org_Mock") 
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.bottom, 20)
            
            Text("Mapa:")
                .foregroundColor(Color(hex: "625C87"))
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                .fontWeight(.bold)

            
            MapView(latitude: 40.7128, longitude: -74.0060)
                .frame(height: 200)
            
            HStack {
                Image(systemName: "globe")
                    .foregroundColor(Color(hex: "625C87"))
                Image(systemName: "link")
                    .foregroundColor(Color(hex: "625C87"))
                Image(systemName: "mail")
                    .foregroundColor(Color(hex: "625C87"))
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(Color(hex: "625C87"))
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
