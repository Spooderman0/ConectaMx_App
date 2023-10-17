//
//  OrgnizationRegisterView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 25/09/23.
//

import SwiftUI

struct OrganizationRegistrationView: View {
    @State private var name = ""
    @State private var alias = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var address = ""
    @State private var webPage = ""
    @State private var instagramUsername = ""
    @State private var facebookPage = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var tagsModel = TagsModel()
    var organizationModel = OrganizationModel()
    
    @State private var navigateToOrgTags = false
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    
                    Image("logoApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Regístrate")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("Nombre de la organización*")
                        TextField("Nombre", text: $name)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Alias")
                        TextField("Alias", text: $alias)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Teléfono*")
                        TextField("Teléfono", text: $phone)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Correo Electrónico*")
                        TextField("Correo electrónico", text: $email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Dirección*")
                        TextField("Dirección", text: $address)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Horarios de atención*")
                            .padding(.vertical, 10)
                        DatePicker(
                            "Inicio",
                            selection: $startTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)
                        
                        DatePicker(
                            "Fin",
                            selection: $endTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)
                        .padding(.bottom, 10)
                        
                        Text("Página web")
                        TextField("Página web", text: $webPage)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        
                        Text("Instagram")
                        TextField("Instagram", text: $instagramUsername)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        
                        Text("Facebook")
                        TextField("Facebook", text: $facebookPage)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                    }
                    
                    HStack(alignment: .bottom){
                        Button(action: {
                            // Add action to go back (e.g., navigation or presentation dismissal)
                        }) {
                            Image(systemName: "return")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: 524848))
                        }
                        .padding()
                        
                        NavigationLink(destination: Organization_Tags(tags: tagsModel.tags), isActive: $navigateToOrgTags) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            // Step 2: Construct an Organization instance
                            let newOrganization = Organization(
                                id: "",  // You might need to handle this field accordingly
                                name: self.name,
                                alias: self.alias,
                                location: Location(address: self.address, city: "", state: "", country: "", zip: ""),  // You might need to modify this line to handle city, state, country, and zip
                                contact: Contact(email: self.email, first_phone: self.phone, second_phone: ""),  // You might need to modify this line to handle second_phone
                                serviceHours: "\(self.startTime) to \(self.endTime)",
                                website: self.webPage,
                                socialMedia: SocialMedia(facebook: self.facebookPage, twitter: "", instagram: self.instagramUsername, linkedIn: ""),  // You might need to modify this line to handle twitter and linkedIn
                                missionStatement: "",
                                logo: "",
                                tags: [],  // You might need to handle this field accordingly
                                RFC: "",
                                postId: []  // You might need to handle this field accordingly
                                
                               
                            )
                            
                            // Step 3: Post the new organization
                            self.organizationModel.postOrganization(organization: newOrganization) { success in
                                if success {
                                    print("Organization posted successfully")
                                } else {
                                    print("Failed to post organization")
                                }
                            }
                            
                            navigateToOrgTags = true
                            
                        }) {
                            Text("Continuar")
//                        NavigationLink(destination: Organization_Tags(tags: tagsModel.tags)) {
//                            Text("Continuar ")
                            .foregroundColor(.white)
                             .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "625C87"))
                            .cornerRadius(10)
                            .padding(.trailing, 45)
                        }
                        
                        }
                    }
                    
                    Spacer()
                    
                    
                }
                .padding()
            }.onAppear(){
                tagsModel.fetchTags()
            }
    }
    }

struct OrganizationRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationRegistrationView()
    }
}
