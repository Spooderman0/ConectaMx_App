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
   // var organizationModel: OrganizationModel
    
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    @State private var activePage: ActivePage = .home
    
    //@Binding
    var tags: [String]
    var orgModel: OrganizationModel
    //var organization: Organization
    //var orgModel = OrganizationModel()
    var organizations = [Organization]()
    
    
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
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
//                            .background(Color(hex: "625C87"))
//                            .foregroundColor(.white)
//                            .cornerRadius(5)
//                        
//                        
//                        
//                        Text(organization.tags[2])
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
//                            .background(Color(hex: "625C87"))
//                            .foregroundColor(.white)
//                            .cornerRadius(5)
//                        
//                        Text(organization.tags[3])
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
//                            .background(Color(hex: "625C87"))
//                            .foregroundColor(.white)
//                            .cornerRadius(5)
//                    }
//                    .padding([.top, .bottom], 5)
//                }
                
                ScrollView {
                    HStack(spacing: 30) {
                        ForEach(organization.tags, id: \.self) { tag in
                            ScrollableTextView(text: tag)
                                .frame(width: 100, height: 40)  // Adjust the frame size as needed
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color(hex: "625C87"))
                                .foregroundColor(.white)
                                .cornerRadius(20)  // Adjust corner radius to achieve oval shape
                        }
                    }
                    .padding([.top, .bottom], 5)
                }

                
            }
            .padding()
        }
    }
}

struct OrganizationDetailView: View {
    //var organizationName: String
    //Fetch specific organization
    //var organization: Organization
    var organization: Organization
    var body: some View {
        ScrollView {
            Text(organization.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(organization.missionStatement)
                .padding(.top, 10)
            
//            Text("Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
//                .padding(.bottom, 10)
            
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
        
        HomeView(/*tags: $dummyTags*/ tags: ["austismo", "cancer"], orgModel: OrganizationModel()/*, organization: mockOrganization*/)
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
