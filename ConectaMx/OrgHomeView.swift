//
//  OrgHomeView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 28/09/23.
//

import SwiftUI

struct PurpleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(configuration.isOn ? Color(hex: "3D3D4E") : Color.gray)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(4)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .onTapGesture {
                    withAnimation {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct ProfileButton: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var isVisible: Bool
    var iconName: String
}

struct SocialButton: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isVisible: Bool
    var image: String
    var url: String
}


struct OrgHomeView: View {
    var orgModel: OrganizationModel
    var organization: Organization?
    
    @State private var description = ""
    
    // Alertas
    @State private var showAlert = false
    @State private var selectedButtonDescription: String = ""
    @State private var selectedButtonTitle: String = ""
    @State private var profileButtons: [ProfileButton] = [
        
        ProfileButton(
            title: "Haz una cita",
            description: "Este botón permite que el usuario agende una cita con tu organización.",
            isVisible: true,
            iconName: "calendar"),
        ProfileButton(
            title: "Contáctanos",
            description: "Este botón permite que el usuario pueda enviarte un mensaje que aparecerán en la pantalla de chats.",
            isVisible: true,
            iconName: "message")
    ]
    
    @State private var socialButtons: [SocialButton] = [
        SocialButton(title: "Web", isVisible: true, image: "web", url: ""),
        SocialButton(title: "Facebook",isVisible: true, image: "facebook", url: ""),
        SocialButton(title: "Instagram",isVisible: true, image: "instagram", url: ""),
        SocialButton(title: "Mail",isVisible: true, image: "mail", url: ""),
        SocialButton(title: "Compartir",isVisible: true, image: "share", url: "")
    ]
    
    @State private var isNotificationViewPresented = false
    
    private func updateSocialButtons() {
            guard let organization = organization else { return }
            
            socialButtons = [
                //SocialButton(title: "Web", isVisible: true, image: "web", url: organization.socialMedia.web ?? ""),
                SocialButton(title: "Facebook", isVisible: true, image: "facebook", url: organization.socialMedia.facebook ?? ""),
                SocialButton(title: "Instagram", isVisible: true, image: "instagram", url: organization.socialMedia.instagram ?? ""),
                SocialButton(title: "Mail", isVisible: true, image: "mail", url: "mailto:\(organization.contact.email)"),
                SocialButton(title: "Compartir", isVisible: true, image: "share", url: "")
            ]
        }
    
    
    var body: some View {
        if let organization = organization {
          //  let description = organization.missionStatement
            
            
            
            ScrollView{
                
                VStack(spacing: 20) {
                    
                    HStack{
                        
                        Spacer()
                        Text(organization.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .onAppear{
                                updateSocialButtons()
                            }
                        
                        Button(action: {
                            
                            isNotificationViewPresented = true
                            
                        }) {
                            
                            HStack {
                                // Ícono
                                Image("notif")
                                    .resizable()
                                    .frame(width: 40, height: 45)
                            }
                            .padding()
                        }
                        .sheet(isPresented: $isNotificationViewPresented) {
                            OrgNotificationView()
                                .presentationDetents([.large, .medium])
                        }
                        
                    }
                    
                    
                    Text("Descripción")
                    TextEditor(text: $description)
                        .frame(height: 150)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    
                    
                    // Vista previa de cómo se verían los botones en el perfil
                    HStack(spacing: 10) {
                        ForEach(profileButtons) { button in
                            if button.isVisible {
                                Button(action: {
                                    // Acción del botón
                                    selectedButtonTitle = button.title
                                    selectedButtonDescription = button.description
                                    showAlert = true
                                }) {
                                    HStack {
                                        // Ícono
                                        Image(systemName: button.iconName)
                                            .foregroundColor(.white)
                                        // Título
                                        Text(button.title)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(Color(hex: "3D3D4E"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("\(selectedButtonTitle)"),
                            message: Text("\(selectedButtonDescription)"),
                            dismissButton: .default(Text("Okay"))
                        )
                    }
                    
                    
                    
                    // Toggles para que la organización decida qué botones mostrar
                    VStack(spacing: 10) {
                        ForEach(profileButtons.indices, id: \.self) { index in
                            Toggle(isOn: $profileButtons[index].isVisible) {
                                Text(profileButtons[index].title)
                            }
                            .toggleStyle(PurpleToggleStyle())
                        }
                    }
                    
                    //Mapa
                    Button(action: {
                        // Acción del botón
                        print("presionado")
                    }) {
                        HStack(spacing: 15){
                            // Ícono
                            Image(systemName: "mappin.and.ellipse")
                            // Título
                            Text("Configurar mapa")
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "3D3D4E"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                OrgMapView()
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .padding([.top, .bottom])
                
                //Social Media buttons
                HStack(spacing: 1) {
                    ForEach(socialButtons) { button in
                        if button.isVisible {
                            Button(action: {
                                // Acción del botón
                                print("presionado")
                            }) {
                                HStack {
                                    // Imagen
                                    Image(button.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 10) {
                        ForEach(socialButtons.indices, id: \.self) { index in
                            Toggle(isOn: $socialButtons[index].isVisible) {
                                Text(socialButtons[index].title)
                            }
                            .toggleStyle(PurpleToggleStyle())
                        }
                    }
                    
                    Spacer()
                        .frame(minHeight: 10)
                    
                    
                }
                .padding()
            }
        }
    }
//    else {
//        Text("Sorry a problem occured getting your infomation try again")
//    }
    
}

struct OrgHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let mockOrganization = Organization(id: "", name: "name", location: Location(address: "", city: "", state: "", country: " ", zip: " "), contact: Contact(email: "", phone: ""), serviceHours: "", socialMedia: SocialMedia(facebook: "", twitter: "", instagram: "", linkedIn: ""), missionStatement: "", tags: ["",""])  // Assuming Organization has a default initializer
        let mockOrgModel = OrganizationModel()  // Assuming OrganizationModel has a default initializer
                
    OrgHomeView(orgModel: mockOrgModel, organization: mockOrganization)
            
    }
}
