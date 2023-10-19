//
//  ContentView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var activePage: ActivePage = .home
    @State var selectedT: Set<String>
    var tagsModel = TagsModel()
    var orgModel = OrganizationModel()
    var postsModel = PostModel()
    var personsModel = PersonModel()
    var fetchedPerson: Person?
    
    

    var body: some View {
//        NavigationView {
            ZStack {
                VStack {
                    switch activePage {
                    case .home:
                        HomeView(tags: tagsModel.tags, orgModel: orgModel, personsModel: personsModel)
                    case .search:
                        SearchView(orgModel: orgModel, tags: tagsModel.tags, personsModel: personsModel, selectedT: selectedT, fetchedPerson: fetchedPerson)
                    case .map:
                        UserOrganizationMap()
                    case .favorites:
                        FavoritesView(orgModel: orgModel, tags: tagsModel.tags)
                    case .profile:
                        ProfileView(personsModel: personsModel, fetchedPerson: fetchedPerson)//personsModel: personsModel)
                    }
                }
                VStack {
                    Spacer()
                    BottomBarView(activePage: $activePage)
                }
            }
        .onAppear(){
                tagsModel.fetchTags()
                postsModel.fetchPosts()
                orgModel.fetchOrganizations()
            personsModel.fetchPerson(phoneNumber: fetchedPerson?.phone ?? "", completion: { (person, error) in
                    if let error = error {
                        // Handle the error
                        print("An error occurred: \(error)")
                    } else if let person = person {
                        // Successfully fetched the person, now you can access the person's properties and methods
                        print("Successfully fetched person: \(person.name)") // Assuming person has a name property
                    } else {
                        // Handle the case where there is no error but the person object is also nil (unlikely, but good to handle all cases)
                        print("No error occurred, but no person was fetched.")
                    }
                })
                // Check if selectedT is empty and assign tags from tagsModel
                if selectedT.isEmpty {
                    selectedT = Set(fetchedPerson?.interestedTags ?? [])
                }else{
//                    personModel?.updatePersonTags(phone: fetchedPerson?.phone, newTags: selectedT, completion: { Bool in
//                        
//                    })
                }
                
                print("Printing Selected tags")
                print(selectedT)
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedT: [""])
    }
}

