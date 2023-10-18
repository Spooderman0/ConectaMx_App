//
//  PersonRegistrationView.swift
//  ConectaMx
//
//  Created by Alumno on 16/10/23.
//

import SwiftUI

struct PersonRegistrationView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToITL = false
    
    var personModel = PersonModel()  
    var tagsModel = TagsModel()
    
    
    func loginUser() {
        
     }
    
    var body: some View {
       
            ScrollView {
                VStack {
                    
                    Image("logoApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Regístrate")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("Name*")
                        TextField("Name", text: $name)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        Text("Password*")
                        TextField("Password", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Phone*")
                        TextField("Phone", text: $phone)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Email*")
                        TextField("Email", text: $email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        
                        
                    }
                    NavigationLink(destination: Intereses_Tags_Login(tags: tagsModel.tags, personModel: personModel, phoneNumber: phone), isActive: $navigateToITL) {
                        EmptyView()
                    }
                    
             
                    Button(action: {
                            
                            let newPerson = Person(
                                id: "",
                                name: self.name,
                                phone: self.phone,
                                email: self.email,
                                password: self.password,
                                interestedTags: [],
                                favorites: []
                            )
                            
                            self.personModel.postPerson(person: newPerson) { success in
                                if success {
                                    print("Person posted successfully")
                                    
//                                    // Fetching the details of the newly registered person
//                                    self.personModel.fetchPerson(phoneNumber: self.phone) { (person, error) in
//                                        if let person = person {
//                                            print("Person fetched successfully")
//                                            self.personModel.fetchedPerson = person // Save fetched person details
//                                            self.navigateToITL = true // Navigate to the next view
                                    personModel.login(phone: phone, password: password) { success, person, error in
                                         if success, let person = person {
                                             print("Login successful")
                                             self.personModel.fetchedPerson = person // Save fetched person details
                                             self.navigateToITL = true // Navigate to the next view
                                         } else {
                                             print("Login failed: \(error ?? "Unknown error")")
                                         }
                                     }
                                        
                                    }
                                   // navigateToITL = true
                                    
                                 else {
                                    print("Failed to post person")
                                }
                            }
                            
                        }) {
                            Text("Registrarte")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "625C87"))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .onAppear(){
                                tagsModel.fetchTags()
                            }
                            
                            

                    }
                    .padding(.top)
                    
                    Spacer()
                    
                }
                .padding()
            }
        }
    
}

struct PersonRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonRegistrationView()
    }
}
