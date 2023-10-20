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
    @StateObject var personModel: PersonModel
    var LL: Bool
    
    
    
    var body: some View {
        //        NavigationView {
        ZStack {
            VStack {
                switch activePage {
                case .home:
                    HomeView(tags: tagsModel.tags, orgModel: orgModel, personsModel: personModel,  LL: LL)
                case .search:
                    SearchView(orgModel: orgModel, tags: tagsModel.tags, personModel: personModel, selectedT: selectedT, LL: LL)
                case .map:
                    UserOrganizationMap()
                case .favorites:
                    FavoritesView(orgModel: orgModel, personModel: personModel, LL: LL)
                case .profile:
                    ProfileView(personModel: personModel,  LL: LL)//personsModel: personsModel)
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
            

            
            print("====================")
            print("Printing LL")
            print(LL)
            print("====================")
            
            if let phone = personModel.fetchedPerson?.phone {
                if selectedT.isEmpty {
                    selectedT = Set(personModel.fetchedPerson?.interestedTags ?? [])
                } else {
                    personModel.updatePersonTags(phone: phone, newTags: Array(selectedT)) { success in
                        if success {
//                            print("Person tags updated successfully")
                        } else {
//                            print("Failed to update person tags")
                        }
                    }
//                    print("Printing Selected tags")
//                    print(selectedT)
                }
            } else {
//                print("Phone number not available")
            }
            
            
            
            
            
            
        }
    }
}


//if let phone = personModel?.fetchedPerson?.phone {
//    personModel?.updatePersonTags(phone: phone, newTags: Array(seleccionadosT)) { success in
//            if success {
//            print("Person tags updated successfully")
//        } else {
//            print("Failed to update person tags")
//        }
//    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedT: [""], personModel: PersonModel(), LL: Bool())
    }
}

