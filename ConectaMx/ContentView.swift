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
   // @StateObject
    var tagsModel = TagsModel()
    var orgModel = OrganizationModel()
    var postsModel = PostModel()
    var personsModel = PersonModel()
    
    

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    switch activePage {
                    case .home:
                        HomeView(tags: tagsModel.tags, orgModel: orgModel)
                    case .search:
                        SearchView(orgModel: orgModel, tags: tagsModel.tags, personsModel: personsModel)
                    case .map:
                        UserOrganizationMap()
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
            orgModel.fetchOrganizations()
            postsModel.fetchPosts()
           // personsModel.fetchPersons()
            personsModel.fetchPerson(phoneNumber: "55-3456-7890") { (person, error) in
                if let person = person {
                    // Handle the retrieved person
                    //print("Retrieved person: \(person.name)")
                } else if let error = error {
                    // Handle the error
                    print("Error fetching person: \(error.localizedDescription)")
                }
            }
            //orgModel.printOrgs()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

