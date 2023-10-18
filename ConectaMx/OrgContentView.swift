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
    
    @Binding var organization: Organization?
    
    var orgModel = OrganizationModel()
    
    var body: some View {
        
           
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
                .onAppear {
                    print(organization?.name)
                }

            }
        
        
    }


struct OrgContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrgContentView(organization: .constant(nil))
    }
}
