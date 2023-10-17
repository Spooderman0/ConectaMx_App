//
//  OrgLoginView.swift
//  ConectaMx
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct OrgLoginView: View {
    @State private var orgID = ""
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
                    
                    if showBanner {
                        BannerView(message: bannerMessage)
                            .opacity(showBanner ? 1 : 0)
                            .animation(.easeInOut(duration: 2))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    self.showBanner = false
                                }
                            }
                    }
                    
                    Image("logoApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Organization Login")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("Organization ID*")
                        TextField("Organization ID", text: $orgID)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                    }
                    
                    NavigationLink(destination: OrgContentView(), isActive: $navigateToCV) {
                        EmptyView()
                    }
                    
                    Button(action: {
                            orgModel.fetchOrganization(organizationId: self.orgID) { organization, error in
                                if let organization = organization {
                                    self.bannerMessage = "Welcome \(organization.name)"
                                    self.showBanner = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.navigateToCV = true
                                    }
                                } else {
                                    self.bannerMessage = "Organization ID not found"  // Error message
                                    self.showBanner = true  // Show the banner with error message
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
