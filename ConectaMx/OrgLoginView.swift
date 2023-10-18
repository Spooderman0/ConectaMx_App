//
//  OrgLoginView.swift
//  ConectaMx
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct OrgLoginView: View {
    @State private var rfc = ""
    @State private var password = ""
    @State private var bannerMessage = ""
    @State private var showBanner = false
    @State private var navigateToCV = false
    
    var orgModel = OrganizationModel()
    var tagsModel = TagsModel()
    @State var seleccionadosT = Set<String>()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // (Banner logic can be uncommented if needed)
                    
                    Image("logoApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Organization Login")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("RFC*")
                        TextField("Enter RFC", text: $rfc)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Password*")
                        SecureField("Enter Password", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                    }
                    
                    NavigationLink(destination: OrgContentView(orgModel: self.orgModel), isActive: $navigateToCV) {
                        EmptyView()
                    }

                    
                    Button(action: {
                        orgModel.fetchOrganization(rfc: self.rfc, password: self.password) { organization, error in
                            if let organization = organization {
                                // (Banner logic can be uncommented if needed)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.navigateToCV = true
                                }
                            } else {
                                // (Banner logic can be uncommented if needed)
                            }
                        }
                    }) {
                        Text("Login")
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
        .onAppear(){
            tagsModel.fetchTags()
        }
    }
        
}

struct OrgLoginView_Previews: PreviewProvider {
    static var previews: some View {
        OrgLoginView()
    }
}
