//
//  FilterSheetView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 20/09/23.
//

import SwiftUI

struct FilterSheetView: View {
    @Binding var selectedT: Set<String>
    var tags: [String]
    var orgModel: OrganizationModel

    
    @ObservedObject var personModel: PersonModel
    @State private var navigateToSV = false

    
    var body: some View {
//        NavigationLink(destination: SearchView(tags: tags, personsModel: personsModel, selectedT: selectedT, isActive: $navigateToSV) {
//            EmptyView()
//        }
        
        
        VStack(spacing: 20) {
            // Título "Filtrar por Intereses:"
            Text("Filtrar por Intereses:")
                .font(.title)
                .fontWeight(.bold)
                
                
            Spacer()
            // Lista de tags
            ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3), spacing: 20) {
                ForEach(tags, id: \.self) { tag in
                    Button(action: {
            if selectedT.contains(tag) {
                selectedT.remove(tag)
            } else {
                selectedT.insert(tag)
            }
            }) {
                Text(tag)
                    .lineLimit(1)
                    .padding(.all, 10)
                    .frame(minWidth: 100) 
                    .background(selectedT.contains(tag) ? Color(hex: "625C87") : Color.gray.opacity(0.2))
                    .foregroundColor(selectedT.contains(tag) ? .white : .black)
                    .cornerRadius(15)
                        }
                    }
                }
            }

            
            // Botón "Aplicar Filtros"
//        Button(action: {
//           //personsModel.fetchedPerson?.interestedTags.removeAll()
//            if let person = personsModel.fetchedPerson {
//                let updatedTags = Array(selectedT)
//                personsModel.updatePersonTags(phone: person.phone, newTags: updatedTags) { success in
//                    if success {
//                        print("Tags updated successfully")
//                    } else {
//                        print("Failed to update tags")
//                    }
//                }
//            }
//                let tagsToSearch = selectedT.joined(separator: ",")
//                    orgModel.fetchOrganizationsByTag(tag: tagsToSearch)
//                }, label: {
//                Text("Aplicar Filtros")
            
            
            Button(action: {
                
                
                    let updatedTags = Array(selectedT)
                personModel.updatePersonTags(phone: personModel.fetchedPerson?.phone ?? "", newTags: updatedTags) { success in
                        if success {
                            print("Tags updated successfully")
                            
                            
                            //let tagsToSearch = selectedT.joined(separator: ",")
                            orgModel.fetchOrganizationsByTags(tags: Array(updatedTags))
                            
                        } else {
                            print("Failed to update tags")
                        }
                    }
//                navigateToSV = true
                
            }, label: {
                Text("Aplicar Filtros")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "625C87"))
                    .cornerRadius(10)
            })
            .padding([.leading, .trailing], 20)

            
            
        }
        .padding()
//        .onAppear {
//            print(selectedTags)
//
//        }
        .onAppear {
            if let person = personModel.fetchedPerson, !person.interestedTags.isEmpty {
                            if selectedT.isEmpty {
                                selectedT = Set(person.interestedTags)
                            }
                        }
            
        }
        
        
        
    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        @State var dummyTags: Set<String> = []
        @State var fetchedPerson: Person? = Person(id: "", name: "", phone: "", email: "", password: "", interestedTags: [""], favorites: [""]) // Assuming Person is your model and it can be initialized like this
        FilterSheetView(selectedT:  $dummyTags,tags: ["autismo", "cancer"], orgModel: OrganizationModel(), personModel: PersonModel())
    }
}

