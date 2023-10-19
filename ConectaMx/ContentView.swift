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
                
                // Check if selectedT is empty and assign tags from tagsModel
                if selectedT.isEmpty {
                    selectedT = Set(fetchedPerson?.interestedTags ?? [])
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

