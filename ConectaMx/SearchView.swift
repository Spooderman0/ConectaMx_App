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
    var tags: [String]
    @State private var selectedTags: Set<String> = []
    var personsModel: PersonModel
    var personas = [PersonModel]()
    var PersonsModel = PersonModel()

    
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
                        FilterSheetView(selectedTags: $selectedTags, tags: tags, personsModel: personsModel)
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
                        // Aqui van a ser las tags que el usario tiene selecionadas
 /*
                        ForEach(["tag1", "tag2", "tag3"], id: \.self) { tag in
                            Text(tag)
                                .foregroundStyle(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color(hex: "625C87"))
                                .cornerRadius(10)
                        }
  */
                        ForEach(personsModel.fetchedPerson?.interestedTags ?? [], id: \.self) { tag in
                            Text(tag)
                                .foregroundStyle(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color(hex: "625C87"))
                                .cornerRadius(10)
                        }

                        
                        
                        
                        
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
                
                // Lista de organizaciones
                ScrollView {
                    VStack {
//                        ForEach(organizaciones, id: \.self) { organizacion in
//                            Button(action: {
//                                self.selectedOrganization = organizacion
//                                self.showDetails = true
//                            }) {
//                                OrganizationView(/*organizationName: organizacion*/)
//                            }
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                            .padding(.bottom, 10)
//                            .padding(.horizontal, 20)
//                        }
//                        .sheet(isPresented: $showDetails) {
//                            OrganizationDetailView(/*organizationName: selectedOrganization*/)
//                        }
                        
                        
                        ForEach(orgModel.organizations) { organization in
                            
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
            PersonsModel.fetchPerson(phoneNumber: "55-3456-7890") { (person, error) in
                if let person = person {
                    // Handle the retrieved person
                    //print("Retrieved person: \(person.name)")
                } else if let error = error {
                    // Handle the error
                    print("Error fetching person: \(error.localizedDescription)")
                }
            }

            print(selectedTags)
            if let person = personsModel.fetchedPerson {
                selectedTags = Set(person.interestedTags)
            }
            print(selectedTags)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var dummyTags: [String] = []

    static var previews: some View {
        SearchView(orgModel: OrganizationModel(), tags: ["autismo", "Cancer"], personsModel: PersonModel())
    }
}

