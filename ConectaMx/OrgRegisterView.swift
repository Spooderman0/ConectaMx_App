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
                        
//                        Button(action: {
//                            // Add your registration logic here
//                            // You can access the entered values using self.name, self.email, etc.
//                            
//
//                        }) {
//                            Text("Continuar")
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color(hex: "625C87"))
//                                .cornerRadius(10)
//                                .padding(.trailing, 45)
//                        }
//                        .padding()
//                        
                        NavigationLink(destination: Organization_Tags(tags: tagsModel.tags)) {
                            Text("Continuar ")
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
