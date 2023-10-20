//
//  FavoritesView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 20/09/23.
//
//
import SwiftUI

struct FavoritesView: View {
    
    @State private var activePage: ActivePage = .favorites
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    
    var orgModel = OrganizationModel()
    var personModel: PersonModel
    @State private var favorites: [Organization] = [] // Assuming Organization is a model
    
    
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                Text("Favoritos:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.bottom, 20)
                
                ScrollView {
                    VStack {
                        ForEach(favorites) { organization in
                            
                            NavigationLink(destination: OrganizationDetailView(organization: organization)) {
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
            
            VStack(spacing: 0) {
                
                //Llamar a barra inferior
                Spacer()
                BottomBarView(activePage: $activePage)
            }
            .zIndex(1)
        }
        .onAppear{
            if let phone = personModel.fetchedPerson?.phone {
                print("first if passed")
                print(phone)
                personModel.getFavoritesByPhone(phone: phone) { (fetchedOrganizations, error) in
                    print("second if passed")
                    if let fetchedOrganizations = fetchedOrganizations {
                        print("third if passed")
                        self.favorites = fetchedOrganizations
                        for organization in fetchedOrganizations {
                            print(organization.name) // Printing organization names as an example
                        }
                    } else if let error = error {
                        print("An error occurred: \(error)")
                    }
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    @State static var dummyTags: [String] = []

    static var previews: some View {
        FavoritesView(orgModel: OrganizationModel(), personModel: PersonModel())
    }
}

