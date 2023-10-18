//  SearchView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 19/09/23.
//

import SwiftUI

struct SearchView: View {

    
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    @State private var searchQuery = ""
    @State private var showFilterSheet = false
    @State private var activePage: ActivePage = .search
    
    
    var orgModel = OrganizationModel()
//    @StateObject var orgModel = OrganizationModel()
    var tags: [String]
    @State var selectedTags: Set<String> = []
    var personsModel: PersonModel
    var personas = [PersonModel]()
    var PersonsModel = PersonModel()
    @State var selectedT: Set<String>
    var fetchedPerson: Person?
    

    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Encabezado con buscador y filtro
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(hex: "625C87").opacity(0.5))
                    TextField("Buscar", text: $searchQuery)
                        .padding(.leading, 5)
                    Button(action: {
                        // Acción para el filtro
                        self.showFilterSheet = true
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(hex: "625C87"))
                    }
                    .sheet(isPresented: $showFilterSheet) {
                        FilterSheetView(selectedT: $selectedT, tags: tags, orgModel: orgModel, personsModel: personsModel)
                    }


                }
                .padding(.all, 10)
                .background(Color(hex: "625C87").opacity(0.1))
                .cornerRadius(10)
                .padding(.bottom, 20)
                .padding(.horizontal)
                
                // Scroll horizontal de tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        ForEach(Array(selectedT), id: \.self) { tag in
                            Text(tag)
                                .foregroundStyle(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color(hex: "625C87"))
                                .cornerRadius(10)
                                .onTapGesture {
                                orgModel.fetchOrganizationsByTag(tag: tag)
                                        }
                        }
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
                
                // Lista de organizaciones
                ScrollView {
                    VStack {
 

                        ForEach(orgModel.tagOrgs) { organization in
                            NavigationLink {
                                OrganizationDetailView(organization: organization)
                            } label: {
                                OrganizationView(organization: organization)
                            }
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 20)
                        }
                   
                    }
                }
            }
            
            VStack {
                //Llamar a barra inferior
                Spacer()
                BottomBarView(activePage: $activePage)
            }
        }
        .padding(.top, 10)
        .onAppear {
//            personsModel.updatePersonTags(phone: fetchedPerson?.phone ?? [], newTags: selectedT) { Bool in
//                
//            }
            
        
//            if let person = personsModel.fetchedPerson {
//                    if !person.interestedTags.isEmpty && selectedT.isEmpty {
//                        // Update selectedTags if they are empty
//                        selectedT = Set(person.interestedTags)
//                    } else if selectedT.isEmpty == false {
//                        // Update person's interested tags if selectedTags is not empty
//                        personsModel.updatePersonTags(phone: person.phone, newTags: Array(selectedTags)) { success in
//                            if success {
//                                print("Person’s tags updated successfully")
//                            } else {
//                                print("Failed to update person’s tags")
//                            }
//                        }
//                    }
//                }
            
            
//                if let person = personsModel.fetchedPerson {
//                    selectedT = Set(person.interestedTags)
//                }
                
            print("*******************")
            print("printing org model tags")
            print(orgModel.tagOrgs.count)
            print("*******************")
            
            print("*******************")
            print("printing selected t")
            print(selectedT)
            print("*******************")
            
//            print("*******************")
//            print("printing person tags")
//            print(PersonModel.fetchPerson(T##self: PersonModel##PersonModel))
//            print("*******************")
            
            
//                print()
//            PersonsModel.fetchPerson(phoneNumber: "55-3456-7890") { (person, error) in
//                if let person = person {
//                } else if let error = error {
//                    print("Error fetching person: \(error.localizedDescription)")
//                }
//            }
//            if let person = personsModel.fetchedPerson {
//                    print("Printing person interested tags")
//                    print(person.interestedTags)
//                            
//                    for tag in person.interestedTags {
//                        orgModel.fetchOrganizationsByTag(tag: tag)
//                    }
//                }
            
            
                            
                    for tag in selectedT {
                        orgModel.fetchOrganizationsByTag(tag: tag)
                    }
            
                
            
//            print("Printing Selected tags before setting")
//            print(selectedTags)
//            if let person = personsModel.fetchedPerson {
//                selectedTags = Set(person.interestedTags)
//            }
//            print("Printing Selected tags after setting")
//            print(selectedTags)
            
            

        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var dummyTags: [String] = []

    static var previews: some View {
        SearchView(orgModel: OrganizationModel(), tags: ["autismo", "Cancer"], personsModel: PersonModel(), selectedT: [""])
    }
}

