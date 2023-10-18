//
//  ConectaMxApp.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI
import SwiftData

@main
struct ConectaMxApp: App {
    var tagsModel = TagsModel()
    var orgModel = OrganizationModel()
    var postsModel = PostModel()
    var personsModel = PersonModel()

    var body: some Scene {
        WindowGroup {
            Inicio_Sesion()
            //ContentView()
            
            
//            Organization_Tags(tags: tagsModel.tags)
//                .onAppear(){
//                    tagsModel.fetchTags()
//                    orgModel.fetchOrganizations()
//                    postsModel.fetchPosts()
//                   // personsModel.fetchPersons()
//                    personsModel.fetchPerson(phoneNumber: "55-3456-7890") { (person, error) in
//                        if let person = person {
//                            // Handle the retrieved person
//                            print("Retrieved person: \(person.name)")
//                        } else if let error = error {
//                            // Handle the error
//                            print("Error fetching person: \(error.localizedDescription)")
//                        }
//                    }
//                    
//                }
        }
        .modelContainer(for: Item.self)
        
        
    }
}
