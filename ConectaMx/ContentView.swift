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
    
    
    
    var body: some View {
        //        NavigationView {
        ZStack {
            VStack {
                switch activePage {
                case .home:
                    HomeView(tags: tagsModel.tags, orgModel: orgModel, personsModel: personModel)
                case .search:
                    SearchView(orgModel: orgModel, tags: tagsModel.tags, personModel: personModel, selectedT: selectedT)
                case .map:
                    UserOrganizationMap()
                case .favorites:
                    FavoritesView(orgModel: orgModel, tags: tagsModel.tags)
                case .profile:
                    ProfileView(personModel: personModel)//personsModel: personsModel)
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
//            personsModel.fetchPerson(phoneNumber: fetchedPerson?.phone ?? "", completion: { (person, error) in
//                if let error = error {
//                    // Handle the error
//                    print("An error occurred: \(error)")
//                } else if let person = person {
//                    // Successfully fetched the person, now you can access the person's properties and methods
//                    print("Successfully fetched person: \(person.name)") // Assuming person has a name property
//                } else {
//                    // Handle the case where there is no error but the person object is also nil (unlikely, but good to handle all cases)
//                    print("No error occurred, but no person was fetched.")
//                }
//            })
            
            
            
            
            
            // Check if selectedT is empty and assign tags from tagsModel
//            if selectedT.isEmpty {
//                print(fetchedPerson?.interestedTags ?? [])
//                selectedT = Set(fetchedPerson?.interestedTags ?? [])
//                print("This print is is selectedT is empty, set selectedT to tags from user")
//                print(selectedT)
//            }else{
//                let stArray = Array(selectedT)
//                personsModel.updatePersonTags(phone: fetchedPerson?.phone ?? "", newTags: stArray) { success in
//                    if success {
//                        print("Tags updated successfully")                }
//                }
//                
//                print("Printing Selected tags")
//                print(selectedT)
//            }
            print("====================")
            print(personModel.fetchedPerson)
            print(selectedT)
            print("====================")

            
            if let phone = personModel.fetchedPerson?.phone {
                if selectedT.isEmpty {
                    selectedT = Set(personModel.fetchedPerson?.interestedTags ?? [])
                    print("This print is if seleccionadosT is empty, set seleccionadosT to tags from user")
                    print(selectedT)
                } else {
                    personModel.updatePersonTags(phone: phone, newTags: Array(selectedT)) { success in
                        if success {
                            print("Person tags updated successfully")
                        } else {
                            print("Failed to update person tags")
                        }
                    }
                    print("Printing Selected tags")
                    print(selectedT)
                }
            } else {
                print("Phone number not available")
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
        ContentView(selectedT: [""], personModel: PersonModel())
    }
}

