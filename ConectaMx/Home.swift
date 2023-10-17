//
//  Home.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI



struct HomeView: View {
    
    
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    @State private var activePage: ActivePage = .home

    var tags: [String]
    var orgModel: OrganizationModel
    var organizations = [Organization]()
    var personsModel: PersonModel
    var personas = [PersonModel]()
    
    
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
                        ForEach(orgModel.organizations) { organization in
                            
                            NavigationLink {
                                OrganizationDetailView(organization: organization)
                            } label: {
                                OrganizationView(organization: organization)
                            }
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 20)

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
    //let organizationName = "String"
    var organization: Organization
    
    var body: some View {
        ZStack {
            Image("Org_Mock")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            Color.black.opacity(0.5)
            
            VStack {
                Text(organization.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(organization.missionStatement)
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 5)
                                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(organization.tags.indices, id: \.self) { index in
                            Text(organization.tags[index])
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(hex: "625C87"))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .lineLimit(1)
                                .frame(minWidth: 100)
                            
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct OrganizationDetailView: View {
    var organization: Organization
    var body: some View {
        ScrollView {
            Text(organization.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(organization.missionStatement)
                .padding(.top, 10)
            
            
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
                
                Button(action: {
                    Image(systemName: "heart")
                        .foregroundColor(Color(hex: "f91100"))
                    
                }) {
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
                Link(destination: URL(string: "https://example.com")!) {
                    Image(systemName: "globe")
                        .foregroundColor(Color(hex: "625C87"))
                }
                Link(destination: URL(string: "https://example.com/link")!) {
                    Image(systemName: "link")
                        .foregroundColor(Color(hex: "625C87"))
                }
                Link(destination: URL(string: "mailto:email@example.com")!) {
                    Image(systemName: "mail")
                        .foregroundColor(Color(hex: "625C87"))
                }
                Link(destination: URL(string: "https://example.com/share")!) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color(hex: "625C87"))
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HomeView(tags: ["austismo", "cancer"], orgModel: OrganizationModel(), personsModel: PersonModel())
    }
}

struct ScrollableTextView: UIViewRepresentable {
    var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
