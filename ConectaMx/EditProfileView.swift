//
//  EditProfileView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 25/09/23.
//
import SwiftUI

struct EditProfileView: View {
    @Binding var profileImage: UIImage?
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var showImagePicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Espacio adicional en la parte superior
            Spacer()
                .frame(height: 20)
            
            // Imagen de perfil
            ZStack {
                Image(uiImage: profileImage ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                // Botón para editar imagen
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color(hex: "FFD465"))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .offset(x: 55, y: 55)
            }
            .padding(.bottom, 30)
            
            // Campos de texto
            VStack(alignment: .leading, spacing: 15) {
                Text("Nombre")
                    .font(.headline)
                TextField("Nombre", text: $name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                
                Text("Teléfono")
                    .font(.headline)
                TextField("Teléfono", text: $phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                
                Text("Correo")
                    .font(.headline)
                TextField("Correo", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Editar Perfil", displayMode: .inline)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$profileImage)
        }
    }
}
