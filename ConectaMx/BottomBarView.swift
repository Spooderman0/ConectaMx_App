import SwiftUI

enum ActivePage {
    case home
    case search
    case favorites
    case profile
}

struct BottomBarView: View {
    @Binding var activePage: ActivePage
    
    var body: some View {
        HStack {
            Button(action: {
                activePage = .home
            }) {
                Image(systemName: activePage == .home ? "house.fill" : "house")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(activePage == .home ? 1.0 : 0.5)
            }
            
            Spacer()
            
            Button(action: {
                activePage = .search
            }) {
                Image(systemName: activePage == .search ? "magnifyingglass" : "magnifyingglass")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(activePage == .search ? 1.0 : 0.5)
            }
            
            Spacer()
            
            Button(action: {
                activePage = .favorites
            }) {
                Image(systemName: activePage == .favorites ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(activePage == .favorites ? 1.0 : 0.5)
            }
            
            Spacer()
            
            Button(action: {
                activePage = .profile
            }) {
                Image(systemName: activePage == .profile ? "person.fill" : "person")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(activePage == .profile ? 1.0 : 0.5)
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .background(Color(hex: "625C87")) 
        .cornerRadius(20)
        .shadow(radius: 15)
        .padding(.horizontal, 6)
        .padding(.bottom, 0)
    }
}
