//
//  Organization_Tags.swift
//  ConectaMx
//
//  Created by Danna Valencia on 27/09/23.
//

import SwiftUI

struct Organization_Tags: View {
    var tags: [String]
    
    
    
//    var orgModel: OrganizationModel
//    
//    init(tags: [String], orgModel: OrganizationModel, orgId: String) {
//        self.tags = tags
//        self.orgModel = orgModel
//    }

    
    @State var seleccionados = Set<String>()
    
    @State private var navigateToOrgContent = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Título "Selecciona tus Intereses:"
            Text("Selecciona los tags de tu organización:")
                .font(.title)
                .fontWeight(.bold)
                
            Spacer()
            // Lista de tags
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            if seleccionados.contains(tag) {
                                seleccionados.remove(tag)
                            } else {
                                seleccionados.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .lineLimit(1) // Asegura que el texto solo ocupa una línea
                                .padding(.all, 10)
                                .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
                                .background(seleccionados.contains(tag) ? Color(hex: "625C87") : Color.gray.opacity(0.2))
                                .foregroundColor(seleccionados.contains(tag) ? .white : .black)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            
            NavigationLink(destination: OrgContentView(orgModel: self.orgModel), isActive: $navigateToOrgContent) {
                EmptyView()
            }
            
//            // Botón "Comenzar"
//            Button(action: {
//                // Acción para comenzar
//                navigateToOrgContent = true
//            }, label: {
//                Text("Comenzar")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color(hex: "625C87"))
//                    .cornerRadius(10)
//            })
//            .padding([.leading, .trailing], 20)
            
            Button(action: {
                orgModel.updateOrganizationTags(organizationId: self.orgId, newTags: Array(seleccionados)) { success in
                    if success {
                        print("Organization tags updated successfully")
                    } else {
                        print("Failed to update organization tags")
                    }
                }
                navigateToOrgContent = true
            }, label: {
                Text("Comenzar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "625C87"))
                    .cornerRadius(10)
            })
            .padding([.leading, .trailing], 20)

            
            // Botón para saltar este paso
            Button(action: {
                // Acción para saltar este paso
                navigateToOrgContent = true
            }, label: {
                Text("Saltar este paso")
                    .underline()
                    .font(.footnote)
                    .foregroundColor(Color(hex: "625C87"))
            })
        }
        .padding()
    }
}

struct Organization_Tags_Previews: PreviewProvider {
    static var previews: some View {
        Organization_Tags(tags: ["autismo", "cancer"], orgModel: OrganizationModel())  // Updated this line
    }
}
