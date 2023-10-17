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
    var selectedT: Set<String>
    var tagsModel = TagsModel()
    var orgModel = OrganizationModel()
    var postsModel = PostModel()
    var personsModel = PersonModel()
    var fetchedPerson: Person?
    
    

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    switch activePage {
                    case .home:
                        HomeView(tags: tagsModel.tags, orgModel: orgModel, personsModel: personsModel)
                    case .search:
                        SearchView(orgModel: orgModel, tags: tagsModel.tags, personsModel: personsModel, selectedT: selectedT)
                    case .favorites:
                        FavoritesView(orgModel: orgModel, tags: tagsModel.tags)
                    case .profile:
                        ProfileView(personsModel: personsModel)//personsModel: personsModel)
                    }
                }
                VStack {
                    Spacer()
                    BottomBarView(activePage: $activePage)
                }
            }
        }
        .onAppear(){
            tagsModel.fetchTags()
            postsModel.fetchPosts()
            orgModel.fetchOrganizations()
            
            
            
            if fetchedPerson == nil {  // Conditionally fetch a new Person only if no Person was passed
                            personsModel.fetchPerson(phoneNumber: "55-3456-7890") { (person, error) in
                                if let person = person {
                                    
                                } else if let error = error {
                                    print("Error fetching person: \(error.localizedDescription)")
                                }
                            }
                        }
            }
            //orgModel.printOrgs()
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedT: [""])
    }
}

