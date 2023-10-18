//
//  OrgHomeView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 28/09/23.
//

import SwiftUI
import MapKit

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




struct OrgHomeView: View {
    var orgModel: OrganizationModel
    var organization: Organization?
    
    @State private var description = ""
    
    // Mapa direción
    @State var calle = "Avenida Eugenio Garza Sada"
    @State var numero = "2411"
    @State var colonia = "Tecnologico"
    @State var cp = "64700"
    @State var ciudad = "Monterrey"
    @State var estado = "N.L."
    @State var pais = "Mexico"
    
    var fullAddress: String {
        "\(calle) \(numero), \(colonia), \(cp), \(ciudad), \(estado), \(pais)"
    }
    
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
    
    // Image Slider
    @State private var items: [ItemSlider] = [
        .init(imageName: "niño", title: "Misión", subTitle: "Ser un referente nacional de inclusión y promoción de derechos de personas con discapacidad intelectual."),
        .init(imageName: "contribuir", title: "Visión", subTitle: "Impulsamos la inclusión y los derechos de las personas con discapacidad intelectual, a través de la educación, formación y vinculación laboral, el acompañamiento de sus familias, y la sensibilización y capacitación en el entorno."),
        .init(imageName: "niños", title: "Valores", subTitle: "Siempre promoviendo valores como la apertura, empatía, integridad, calidad y colaboración."),
        .init(imageName: "voluntariado", title: "Abriendo posibilidades, cerrando diferencias.", subTitle: "")
    ]
    /// Customization Properties
    @State private var showPagingControl: Bool = false
    @State private var disablePagingInteraction: Bool = false
    @State private var pagingSpacing: CGFloat = 20
    @State private var titleScrollSpeed: CGFloat = 0.6
    @State private var stretchContent: Bool = false
    
    @State private var isNotificationViewPresented = false
    @State private var isMapSheetPresented = false
    
    
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
            
            
            NavigationView{
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
                        
                        HStack{
                            Image(systemName: "pencil.line")
                            Text("Descripción")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color(hex: "3D3D4E"))
                        }
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
                        
                        // Slider
                        VStack {
                            CustomPagingSlider(
                                showPagingControl: showPagingControl,
                                disablePagingInteraction: disablePagingInteraction,
                                titleScrollSpeed: titleScrollSpeed,
                                pagingControlSpacing: pagingSpacing,
                                data: $items
                            ) { $item in
                                /// Content View
                                NavigationLink(destination: FullImageView(imageName: item.imageName)) {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: stretchContent ? nil : 280, height: stretchContent ? 320 : 220)
                                        .cornerRadius(15)
                                }
                                
                                
                            } titleContent: { $item in
                                /// Title View
                                VStack(spacing: 5) {
                                    Text(item.title)
                                        .font(.largeTitle.bold())
                                    
                                    Text(item.subTitle)
                                        .foregroundStyle(.gray)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(10) // Aquí puedes limitar el número de líneas si lo deseas
                                        .minimumScaleFactor(0.7) // Ajusta este valor según tus necesidades
                                }
                                .padding(.bottom, 5)
                            }
                            /// Use Safe Area Padding to avoid Clipping of ScrollView
                            .safeAreaPadding([.horizontal, .top], 35)
                        }
                    }
                    
                    // Botón de configurar mapas
                    Button(action: {
                        isMapSheetPresented.toggle() // Cambia el valor de isSheetPresented
                    }) {
                        HStack {
                            // Ícono
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.white)
                            // Título
                            Text("Configurar Mapa")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "3D3D4E"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .sheet(isPresented: $isMapSheetPresented, content: {
                        OrganizationMapView(calle: $calle, numero: $numero, colonia: $colonia, cp: $cp, ciudad: $ciudad, estado: $estado, pais: $pais)
                            .presentationDetents([.large, .large])
                    })
                    
                    
                    
                    // Mapa
                    //OrgMapView(calle: calle, numero: numero, colonia: colonia, cp: cp, ciudad: ciudad, estado: estado, pais: pais)
                    //  .frame(height: UIScreen.main.bounds.height / 3)
                    //.padding([.top, .bottom])
                    
                    
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
}
//    else {
//        Text("Sorry a problem occured getting your infomation try again")
//    }
    


struct OrgHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let mockOrganization = Organization(
            id: "001",
            name: "Mock Organization",
            alias: "MockOrg",
            location: Location(
                address: "123 Mock St",
                city: "MockCity",
                state: "MockState",
                country: "MockCountry",
                zip: "12345"
            ),
            contact: Contact(
                email: "mock@organization.com",
                first_phone: "123-456-7890",
                second_phone: "098-765-4321"
            ),
            serviceHours: "9am - 5pm",
            website: "www.mockorganization.com",
            socialMedia: SocialMedia(
                facebook: "mockFacebook",
                twitter: "mockTwitter",
                instagram: "mockInstagram",
                linkedIn: "mockLinkedIn",
                youtube: "mockYouTube",
                tiktok: "mockTikTok",
                whatsapp: "mockWhatsApp"
            ),
            missionStatement: "Making the world a better place through mock services.",
            logo: "mockLogoURL",
            tags: ["MockTag1", "MockTag2"],
            RFC: "MOCKRFC123",
            postId: ["post1", "post2"],
            followers: ["follower1", "follower2", "follower3"],
            password: "mockPassword"
        )
        let mockOrgModel = OrganizationModel()  // Assuming OrganizationModel has a default initializer
                
    OrgHomeView(orgModel: mockOrgModel, organization: mockOrganization)
            
    }
}
