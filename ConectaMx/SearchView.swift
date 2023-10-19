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
    @State var fetchedPerson: Person?
    

    
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
                        FilterSheetView(selectedT: $selectedT, tags: tags, orgModel: orgModel, fetchedPerson: $fetchedPerson, personsModel: personsModel)
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
                    for tag in selectedT {
                        print(tag)
                        orgModel.fetchOrganizationsByTag(tag: tag)
                    }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var dummyTags: [String] = []

    static var previews: some View {
        SearchView(orgModel: OrganizationModel(), tags: ["autismo", "Cancer"], personsModel: PersonModel(), selectedT: [""])
    }
}

