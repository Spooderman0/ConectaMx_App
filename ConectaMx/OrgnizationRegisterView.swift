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
    
    var body: some View {
        ScrollView{
            VStack {
                
                Image("logoApp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("Regístrate")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Nombre de la organización*")
                    TextField("Nombre", text: $name)
                        .background(Color(hex: 0xedeef1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
    
                    
                }
                .padding()
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Alias")
                    TextField("Alias", text: $alias)
                        .background(Color.gray.opacity(0.9))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Teléfono*")
                    TextField("Teléfono", text: $phone)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Correo Electrónico*")
                    TextField("Correo electrónico", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Dirección*")
                    TextField("Dirección", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 1) {
                    Text("Horarios de atención")
                        .padding(.vertical)
                    DatePicker(
                    "Inicio",
                    selection: $startTime,
                    displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.compact)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 1) {
                    Text("")
                    DatePicker(
                        "Fin",
                        selection: $endTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.compact)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Página web")
                    TextField("Página web", text: $webPage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Instagram")
                    TextField("Instagram", text: $instagramUsername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Facebook")
                    TextField("Facebook", text: $facebookPage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
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
                    
                    Button(action: {
                        // Add your registration logic here
                        // You can access the entered values using self.name, self.email, etc.
                    }) {
                        Text("Continuar")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "625C87"))
                            .cornerRadius(10)
                            .padding(.trailing, 45)
                    }
                    .padding()
                    
                }
                
                Spacer()
                

            }
            .padding()
        }
    }
}

struct OrganizationRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationRegistrationView()
    }
}
