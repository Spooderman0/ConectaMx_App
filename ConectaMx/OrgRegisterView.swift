//
//  OrgnizationRegisterView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 25/09/23.
//

import SwiftUI

struct OrganizationRegistrationView: View {
    @State private var name = ""
    @State private var rfc = ""
    @State private var password = ""
    @State private var alias = ""
    @State private var phone = ""
    @State private var secondPhone = "" // Added second phone
    @State private var email = ""
    @State private var address = ""
    @State private var city = "" // Added city
    @State private var state = "" // Added state
    @State private var country = "" // Added country
    @State private var zip = "" // Added zip
    @State private var webPage = ""
    @State private var instagramUsername = ""
    @State private var facebookPage = ""
    @State private var youtubePage = ""
    @State private var tiktokPage = ""
    @State private var whatsappNumber = ""
    @State private var twitterPage = "" // Added twitter
    @State private var linkedInPage = "" // Added LinkedIn
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var tagsModel = TagsModel()
    var organizationModel = OrganizationModel()
    
   
    
    @State private var navigateToOrgTags = false
    @State private var fetchedOrganization: Organization?

    
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
                        
                        Text("RFC*")
                        TextField("RFC", text: $rfc)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Password*")
                        SecureField("Password", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        
                        
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
                        
                        Text("Segundo Teléfono")
                        TextField("Segundo Teléfono", text: $secondPhone)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))

                        
                        Text("Correo Electrónico*")
                        TextField("Correo electrónico", text: $email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Dirección*")
//                        TextField("Dirección", text: $address)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Ciudad*")
                        TextField("Ciudad", text: $city)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Estado*")
                        TextField("Estado", text: $state)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("País*")
                        TextField("País", text: $country)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Código Postal*")
                        TextField("Código Postal", text: $zip)
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
                        
                        Text("YouTube")
                        TextField("YouTube", text: $youtubePage)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("TikTok")
                        TextField("TikTok", text: $tiktokPage)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("WhatsApp")
                        TextField("WhatsApp", text: $whatsappNumber)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        
                        
                        Text("Twitter")
                        TextField("Twitter", text: $twitterPage)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("LinkedIn")
                        TextField("LinkedIn", text: $linkedInPage)
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
                        
                        NavigationLink(
                            destination: Organization_Tags(tags: tagsModel.tags, organizationModel: organizationModel),  // Use the @State variable here
                            isActive: $navigateToOrgTags
                        ) {
                            EmptyView()
                        }

                        
//                        Button(action: {
//                            // Step 2: Construct an Organization instance
//                            let newOrganization = Organization(
//                                id: "",  // You might need to handle this field accordingly
//                                name: self.name,
//                                alias: self.alias,
//                                location: Location(address: self.address, city: "", state: "", country: "", zip: ""),  // You might need to modify this line to handle city, state, country, and zip
//                                contact: Contact(email: self.email, first_phone: self.phone, second_phone: ""),  // You might need to modify this line to handle second_phone
//                                serviceHours: "\(self.startTime) to \(self.endTime)",
//                                website: self.webPage,
//                                socialMedia: SocialMedia(facebook: self.facebookPage, twitter: "", instagram: self.instagramUsername, linkedIn: ""),  // You might need to modify this line to handle twitter and linkedIn
//                                missionStatement: "",
//                                logo: "",
//                                tags: [],  // You might need to handle this field accordingly
//                                RFC: "",
//                                postId: []  // You might need to handle this field accordingly
//                                
//                               
//                            )
//                            
//                            // Step 3: Post the new organization
//                            self.organizationModel.postOrganization(organization: newOrganization) { success in
//                                if success {
//                                    print("Organization posted successfully")
//                                } else {
//                                    print("Failed to post organization")
//                                }
//                            }
//                            
//                            navigateToOrgTags = true
//                            
//                        }) {
//                            Text("Continuar")

                        Button(action: {
                            // Step 2: Construct an Organization instance
                            let newOrganization = Organization(
                                id: "",
                                name: self.name,
                                alias: self.alias,
                                location: Location(address: self.address, city: self.city, state: self.state, country: self.country, zip: self.zip),
                                contact: Contact(email: self.email, first_phone: self.phone, second_phone: self.secondPhone),
                                serviceHours: "\(self.startTime) to \(self.endTime)",
                                website: self.webPage,
                                socialMedia: SocialMedia(
                                        facebook: self.facebookPage,
                                        twitter: self.twitterPage,
                                        instagram: self.instagramUsername,
                                        linkedIn: self.linkedInPage,
                                        youtube: self.youtubePage, // Updated
                                        tiktok: self.tiktokPage,   // Updated
                                        whatsapp: self.whatsappNumber  // Updated
                                    ),
                                missionStatement: "",
                                logo: "",
                                tags: [],
                                RFC: self.rfc,
                                postId: [],
                                followers: [],  // Added a default value of 0, you may update it based on your needs
                                password: self.password  // Added, assuming password is entered by user and captured in a State variable
                                    
                            )
                            
                            // Step 3: Post the new organization
                                self.organizationModel.postOrganization(organization: newOrganization) { success in
                                    if success {
                                        print("Organization posted successfully")
                                        
                                        // Step 4: Fetch the newly created organization
                                        self.organizationModel.fetchOrganization(rfc: self.rfc, password: self.password) { organization, error in
                                            if let organization = organization {
                                                // Set the @State variable
                                                self.fetchedOrganization = organization
                                                
                                                // Step 5: Navigate to Organization_Tags view
                                                DispatchQueue.main.async {
                                                    self.navigateToOrgTags = true
                                                }
                                            } else {
                                                print("Failed to fetch organization: \(error?.localizedDescription ?? "Unknown error")")
                                            }
                                        }
                                        
                                    } else {
                                        print("Failed to post organization")
                                    }
                                }
                            }) {
                                Text("Continuar")
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
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
