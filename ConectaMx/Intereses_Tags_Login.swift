//
//  Intereses_Tags_Login.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

// Intereses_Tags_Login.swift

import SwiftUI

struct Intereses_Tags_Login: View {
    var tags: [String]
    var personModel: PersonModel? 
    var phoneNumber: String?
    var LL: Bool
    
    
    @State var seleccionadosT = Set<String>()
    @State private var navigateToContent = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Selecciona tus Intereses:")
                .font(.title)
                .fontWeight(.bold)
            
            
            Spacer()
            // Lista de tags
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3), spacing: 20) {
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            if seleccionadosT.contains(tag) {
                                seleccionadosT.remove(tag)
                            } else {
                                seleccionadosT.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .lineLimit(1) // Asegura que el texto solo ocupa una línea
                                .padding(.all, 10)
                                .frame(minWidth: 100) // Establece un ancho mínimo para cada tag
                                .background(seleccionadosT.contains(tag) ? Color(hex: "625C87") : Color.gray.opacity(0.2))
                                .foregroundColor(seleccionadosT.contains(tag) ? .white : .black)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            
//            NavigationLink(destination: ContentView(selectedT: seleccionadosT, personModel: personModel!), isActive: $navigateToContent) {
//                EmptyView()
//            }
            
            NavigationLink(destination: personModel.map { ContentView(selectedT: seleccionadosT, personModel: $0, LL: LL) } ?? ContentView(selectedT: seleccionadosT, personModel: PersonModel(), LL: LL), isActive: $navigateToContent) {
                EmptyView()
            }


            
            // Botón "Comenzar"
//            Button(action: {
//                            if let phone = phoneNumber, let model = personModel {
//                                personModel?.updatePersonTags(phone: fetchedPerson?.phone ?? , newTags: Array(seleccionadosT)) { success in
//                                    if success {
//                                        print("Person tags updated successfully")
//                                    } else {
//                                        print("Failed to update person tags")
//                                    }
//                                }
//                            }
//                            navigateToContent = true
//                        }, label: {
            
                
            
            Button(action: {
                if LL == true{
                    if let model = personModel, let phone = model.fetchedPerson?.phone {
                        model.updatePersonTags(phone: phone, newTags: Array(seleccionadosT)) { success in
                            if success {
                            print("Person tags updated successfully")
                        } else {
                            print("Failed to update person tags")
                        }
                    }
                    
                }else{
                    print("was NOT able")
                }
                    navigateToContent = true
                }else {
                    navigateToContent = true
                }
            }, label: {
                    Text("Comenzar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "625C87"))
                    .cornerRadius(10)
            })
            .padding([.leading, .trailing], 20)
            
            
            NavigationLink(destination: ContentView(selectedT: seleccionadosT, personModel: personModel!, LL: LL)) {
                Text("Saltar este paso")
                    .underline()
                    .font(.footnote)
                    .foregroundColor(Color(hex: "625C87"))
            }
        }
        .padding(10)
        .onAppear{
            print("Value of LL is:")
            print(LL)
  
        }
        
    }
}

struct Intereses_Tags_Login_Previews: PreviewProvider {
    static var previews: some View {
        Intereses_Tags_Login(tags: ["autismo", "cancer"], LL: false)
    }
}
