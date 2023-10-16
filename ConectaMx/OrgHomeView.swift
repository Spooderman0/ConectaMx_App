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

struct SocialButton: Identifiable{
    var id: UUID = UUID()
    var title: String
    var isVisible: Bool
    var image: String
}

struct OrgHomeView: View {
    
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
    
        SocialButton(title: "Web", isVisible: true, image: "web"),
        SocialButton(title: "Facebook",isVisible: true, image: "facebook"),
        SocialButton(title: "Instagram",isVisible: true, image: "instagram"),
        SocialButton(title: "Mail",isVisible: true, image: "mail"),
        SocialButton(title: "Compartir",isVisible: true, image: "share")

    ]
    
    @State private var isNotificationViewPresented = false
    
    
    var body: some View {
        
        ScrollView{
            
            VStack(spacing: 20) {
                
                HStack{
                    
                    Spacer()
                    Text("Organización")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

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

struct OrgHomeView_Previews: PreviewProvider {
    static var previews: some View {
        OrgHomeView()
    }
}
