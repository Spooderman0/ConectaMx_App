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
    
    var personsModel = PersonModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    switch activePage {
                    case .home:
                        OrgHomeView()
                    case .messages:
                        OrganizationInboxView()
                    case .profile:
                        OrgProfileView(personsModel: PersonModel())
                    }
                }
                VStack {
                    Spacer()
                    OrgBottomBarView(activePage: $activePage)
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
