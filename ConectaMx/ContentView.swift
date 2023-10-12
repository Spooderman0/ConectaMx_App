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
                        SearchView(tags: tagsModel.tags)
                    case .favorites:
                        FavoritesView(tags: tagsModel.tags)
                    case .profile:
                        ProfileView()//personsModel: personsModel)
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
            personsModel.fetchPersons()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

