//
//  OrganizationInboxView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 28/09/23.
//

import SwiftUI

struct User: Identifiable {
    var id: UUID
    var name: String
    var image: Image
}

struct  OrganizationInboxView: View {
    @State private var searchText = ""
    let users: [User] = [
        User(id: UUID(), name: "Juan Ramírez", image: Image("messi_mock")),
        User(id: UUID(), name: "Maria Romero", image: Image("messi_mock")),
    ]

    var body: some View {
        VStack(spacing: 10) {
            Spacer().frame(height: 60)
            
            SearchBar(text: $searchText)
                .padding(.top, 10)

            Text("Chat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            List(users) { user in
                HStack {
                    user.image
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Text(user.name)
                        .font(.title3)
                }
                .background(Color.white) // Hace que cada fila tenga un fondo blanco
            }
            .listStyle(PlainListStyle()) // Elimina los dividers y estilos por defecto de la lista
        }
        .padding()
        .background(Color.white) // Fondo blanco para toda la vista
        .edgesIgnoringSafeArea(.all) // Asegura que el fondo blanco cubra toda la pantalla
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
            
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(hex: "3D3D4E")
            textField.textColor = UIColor.white
            textField.tintColor = UIColor.white
            textField.attributedPlaceholder = NSAttributedString(string: "...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                
            textField.font = UIFont.systemFont(ofSize: 20)
            textField.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
                
            // Ajuste del ícono de lupa:
            if let glassIconView = textField.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = UIColor.white
                    
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: glassIconView.frame.size.width + 20, height: glassIconView.frame.size.height))
                paddingView.addSubview(glassIconView)
                glassIconView.frame.origin.x = 20 // Esto añade 20pts de padding a la izquierda
                    
                textField.leftView = paddingView
            }
        }

        return searchBar
    }



    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        let parent: SearchBar

        init(_ parent: SearchBar) {
            self.parent = parent
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.text = searchText
        }
    }
}


struct  OrganizationInboxView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationInboxView()
    }
}





