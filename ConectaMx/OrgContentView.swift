//
//  OrgContentView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 11/10/23.
//

import SwiftUI
import SwiftData

struct OrgContentView: View {
    @State private var activePage: OrgActivePage = .home
    
    @State private var organization: Organization?
    
    var orgModel = OrganizationModel()
    
    var body: some View {
        
            NavigationView {
                ZStack {
                    VStack {
                        switch activePage {
                        case .home:
                            OrgHomeView(orgModel: orgModel, organization: organization)
                        case .messages:
                            OrganizationInboxView()
                        case .profile:
                            OrgProfileView()
                        }
                    }
                    VStack {
                        Spacer()
                        OrgBottomBarView(activePage: $activePage)
                    }
                }
            }
            .onAppear {
                let organizationId = "652573ca0130690d2581318f"
                
                orgModel.fetchOrganization(organizationId: organizationId) { fetchedOrganization, error in
                    if let fetchedOrganization = fetchedOrganization {
                        self.organization = fetchedOrganization
                    } else if let error = error {
                        print("Error fetching organization: \(error)")
                    }
                }
            }
        }
        
    }


struct OrgContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrgContentView()
    }
}
