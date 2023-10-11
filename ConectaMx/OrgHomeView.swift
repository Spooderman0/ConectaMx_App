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
    var isVisible: Bool
    var iconName: String
}

struct SocialButton: Identifiable{
    var id: UUID = UUID()
    var isVisible: Bool
    var iconName: String
}

struct OrgHomeView: View {
    
    @State private var description = ""
    
    @State private var profileButtons: [ProfileButton] = [
        
        ProfileButton(title: "Haz una cita", isVisible: true, iconName: "calendar"),
        ProfileButton(title: "Contáctanos", isVisible: true, iconName: "message")
    ]

    
    var body: some View {
        
        ScrollView{
            
            VStack(spacing: 20) {
                
                Text("Organización")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
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
                                print("\(button.title) presionado")
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

                
                // Toggles para que la organización decida qué botones mostrar
                VStack(spacing: 10) {
                    ForEach(profileButtons.indices, id: \.self) { index in
                        Toggle(isOn: $profileButtons[index].isVisible) {
                            Text(profileButtons[index].title)
                        }
                        .toggleStyle(PurpleToggleStyle())
                    }
                }
                
                //Maoa
                Text("Mapa:")
                    .foregroundColor(Color(hex: "625C87"))
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .fontWeight(.bold)
                
                
                OrganizationMapView(latitude: 40.7128, longitude: -74.0060)
                    .frame(height: 200)
                 
                
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

/*

struct OrgHomeView: View {

    
    var organizationName: String
        
        var body: some View {
            
            ScrollView {
                
                
                Text("Mapa:")
                    .foregroundColor(Color(hex: "625C87"))
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .fontWeight(.bold)

                
                OrganizationMapView(latitude: 40.7128, longitude: -74.0060)
                    .frame(height: 200)
            }
            .padding()
        }
    }


#Preview {
    OrgHomeView(organizationName: "Arena")
}

 */


