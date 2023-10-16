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
//                    .onAppear {
//                          
//                        print(organizations.count)
//                        print(orgModel.organizations.count)
//                       }
               
                ScrollView {
                    VStack {
//                        ForEach(organizations) { organization in
//                        Button(action: {
//                            //self.selectedOrganization = organization
//                            self.showDetails = true
//                    })  {
//                                OrganizationView(organization: organization)
//                            }
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                            .padding(.bottom, 10)
//                            .padding(.horizontal, 20)
//                        }
//                        .sheet(isPresented: $showDetails) {
//                            OrganizationDetailView()
//                        }
                      
                        
//Working view for orgs, not for detailed view
//                ForEach(orgModel.organizations) { organization in
//                    OrganizationView(organization: organization)
//                    //print("helo")
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                        .padding(.bottom, 10)
//                        .padding(.horizontal, 20)
//                        
//                        }
//                    
//                .sheet(isPresented: $showDetails) {
//                    OrganizationDetailView()
//                        }
                        
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
                
//                ScrollView{
//                    HStack(spacing: 30) {
//                        Text(organization.tags[1])
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(Color(hex: "625C87"))
//                            .foregroundColor(.white)
//                            .cornerRadius(5)
//                            .lineLimit(1) // Asegura que el texto solo ocupa una línea
////                            .padding(.all, 10)
//                            .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
//                        
//                        
//                        
//                        Text(organization.tags[2])
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(Color(hex: "625C87"))
//                            .foregroundColor(.white)
//                            .cornerRadius(5)
//                            .lineLimit(1) // Asegura que el texto solo ocupa una línea
////                            .padding(.all, 10)
//                            .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
//                            
//                        Text(organization.tags[3])
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(Color(hex: "625C87"))
//                            .foregroundColor(.white)
//                            .cornerRadius(5)
//                            .lineLimit(1) // Asegura que el texto solo ocupa una línea
////                            .padding(.all, 10)
//                            .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
//                    }
//                    .padding([.top, .bottom], 5)
//                }
                
                
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
            
//            HStack {
//                Image(systemName: "globe")
//                    .foregroundColor(Color(hex: "625C87"))
//                Image(systemName: "link")
//                    .foregroundColor(Color(hex: "625C87"))
//                Image(systemName: "mail")
//                    .foregroundColor(Color(hex: "625C87"))
//                Image(systemName: "square.and.arrow.up")
//                    .foregroundColor(Color(hex: "625C87"))
            
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
        
        
        //let organizationModel = OrganizationModel()
                
                // Mocking an organization
                var mockOrganization = Organization(
                    id: "1",
                    name: "Mock Organization",
                    location: Location(address: "123 Main St", city: "Anytown", state: "AN", country: "Country", zip: "12345"),
                    contact: Contact(email: "email@example.com", phone: "123-456-7890"),
                    serviceHours: "9-5",
                    socialMedia: SocialMedia(facebook: "", twitter: "", instagram: "", linkedIn: ""),
                    missionStatement: "Making the world a better place.",
                    tags: ["tag1", "tag2"]
                )
                
                //organizationModel.organizations = [mockOrganization]
        
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
