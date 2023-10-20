//
//  Home.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI
import MapKit


struct HomeView: View {
    
    
    @State private var showDetails = false
    @State private var selectedOrganization = ""
    @State private var activePage: ActivePage = .home
    

    var tags: [String]
    var orgModel: OrganizationModel
    var organizations = [Organization]()
    var personsModel: PersonModel
    var personas = [PersonModel]()
    var LL: Bool
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                Text("Organizaciones:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.bottom, 20)

               
                ScrollView {
                    VStack {
                        ForEach(orgModel.organizations) { organization in
                            
                            NavigationLink {
                                OrganizationDetailView(organization: organization, LL: LL, personModel: personsModel)
                            } label: {
                                OrganizationView(organization: organization)
                            }
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 20)

                        }

                    }
                }
            }
            
            VStack(spacing: 0) {
                
                //Llamar a barra inferior
                Spacer()
                BottomBarView(activePage: $activePage)
            }
            .zIndex(1)
        }
        .onAppear{
            print("====================")
            print("Printing LL for home")
            print(LL)
            print("====================")
        }
    }
}

struct OrganizationView: View {
    //let organizationName = "String"
    var organization: Organization
    
    
    var body: some View {
        ZStack {
            Image("Org_Mock")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            Color.black.opacity(0.5)
            
            VStack {
                Text(organization.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(organization.missionStatement)
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 5)
                                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(organization.tags.indices, id: \.self) { index in
                            Text(organization.tags[index])
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(hex: "625C87"))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .lineLimit(1)
                                .frame(minWidth: 100)
                            
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct OrganizationDetailView: View {
    var organization: Organization
    let map = [OrganizationMap(id: 1, name: "Paz Es", coordinate: CLLocationCoordinate2D(latitude: 25.649837, longitude: -100.289034))]
    
    @State private var socialButtons: [SocialButton] = [
        SocialButton(title: "Web", isVisible: true, image: "web", url: ""),
        SocialButton(title: "Facebook",isVisible: true, image: "facebook", url: ""),
        SocialButton(title: "Instagram",isVisible: true, image: "instagram", url: ""),
        SocialButton(title: "Mail",isVisible: true, image: "mail", url: ""),
        SocialButton(title: "Compartir",isVisible: true, image: "share", url: "")
    ]
    
    // Image Slider
    @State private var items: [ItemSlider] = [
        .init(imageName: "niño", title: "Misión", subTitle: "Ser un referente nacional de inclusión y promoción de derechos de personas con discapacidad intelectual."),
        .init(imageName: "contribuir", title: "Visión", subTitle: "Impulsamos la inclusión y los derechos de las personas con discapacidad intelectual, a través de la educación, formación y vinculación laboral, el acompañamiento de sus familias, y la sensibilización y capacitación en el entorno."),
        .init(imageName: "niños", title: "Valores", subTitle: "Siempre promoviendo valores como la apertura, empatía, integridad, calidad y colaboración."),
        .init(imageName: "voluntariado", title: "Abriendo posibilidades, cerrando diferencias.", subTitle: "")
    ]
    /// Customization Properties
    @State private var showPagingControl: Bool = false
    @State private var disablePagingInteraction: Bool = false
    @State private var pagingSpacing: CGFloat = 20
    @State private var titleScrollSpeed: CGFloat = 0.6
    @State private var stretchContent: Bool = false
    @State private var isHeartFilled = false
    var LL: Bool
    var personModel: PersonModel
    
    var body: some View {
        ScrollView {
            Text(organization.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(organization.missionStatement)
                .padding(.top, 10)
            
            
            HStack {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(hex: "625C87"))
                        Text("Haz Cita")
                            .foregroundStyle(Color(hex: "625C87"))
                        
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "message")
                            .foregroundColor(Color(hex: "625C87"))
                        Text("Contáctanos")
                            .foregroundStyle(Color(hex: "625C87"))
                    }
                }
                
                Spacer()
                
                if LL == true{
                    FavoriteButton(personModel: personModel, orgId: organization.id)
                }else {
                    
                }
//                print("favs button should be working")
//                {
//                    if isHeartFilled {
//                        Image(systemName: "heart.fill") // Filled heart icon
//                            .foregroundColor(Color(hex: "f91100"))
//
//                        
//                        
//                    } else {
//                        Image(systemName: "heart") // Empty heart icon
//                            .foregroundColor(Color(hex: "625C87"))
//                    }
//                }
                
        }
        .padding([.top,.bottom],20)
            
            // Slider
            VStack {
                CustomPagingSlider(
                    showPagingControl: showPagingControl,
                    disablePagingInteraction: disablePagingInteraction,
                    titleScrollSpeed: titleScrollSpeed,
                    pagingControlSpacing: pagingSpacing,
                    data: $items
                ) { $item in
                    /// Content View
                    NavigationLink(destination: FullImageView(imageName: item.imageName)) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: stretchContent ? nil : 280, height: stretchContent ? 320 : 220)
                            .cornerRadius(15)
                    }
                    
                    
                } titleContent: { $item in
                    /// Title View
                    VStack(spacing: 5) {
                        Text(item.title)
                            .font(.largeTitle.bold())
                        
                        Text(item.subTitle)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .lineLimit(10) // Aquí puedes limitar el número de líneas si lo deseas
                            .minimumScaleFactor(0.7) // Ajusta este valor según tus necesidades
                    }
                    .padding(.bottom, 5)
                }
                /// Use Safe Area Padding to avoid Clipping of ScrollView
                .safeAreaPadding([.horizontal, .top], 35)
            }
            
            Text("Mapa:")
                .foregroundColor(Color(hex: "625C87"))
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                .fontWeight(.bold)

            //25.649837, -100.289034
            MapView(organizations: map)
                .frame(height: 200)
            
         
            HStack(spacing: 1) {
                ForEach(socialButtons) { button in
                    if button.isVisible {
                        Button(action: {
                            // Acción del botón
                            print("presionado")
                        }) {
                            HStack {
                                // Imagen
                                Image(button.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .padding()
                            .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(tags: ["austismo", "cancer"], orgModel: OrganizationModel(), personsModel: PersonModel(), LL: false)
    }
}

struct ScrollableTextView: UIViewRepresentable {
    var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct FavoriteButton: View {
    @ObservedObject var personModel: PersonModel
    var orgId: String
    @State private var isFavorite: Bool = false
    
    var body: some View {
        Button(action: toggleFavorite) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .onAppear(perform: checkIfFavorite) // Call the function when the view appears
        }
    }
    
    func checkIfFavorite() {
        if let phone = personModel.fetchedPerson?.phone {
            personModel.checkFavoriteByPhone(phone: phone, orgId: orgId) { isInFavorites, error in
                if let error = error {
                    print("Error checking favorite status: \(error.localizedDescription)")
                } else {
                    isFavorite = isInFavorites
                }
            }
        }
    }
    
    func toggleFavorite() {
        print("calling toggle favs function")
        if let phone = personModel.fetchedPerson?.phone {
            if isFavorite {
                // Remove from favorites
                personModel.removeFavoriteByPhone(phone: phone, orgId: orgId) { success, error in
                    if success {
                        isFavorite = false
                    } else {
                        print("Failed to remove from favorites. Error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            } else {
                // Add to favorites
                personModel.addFavoriteByPhone(phone: phone, orgId: orgId) { success, error in
                    if success {
                        isFavorite = true
                    } else {
                        print("Failed to add to favorites. Error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        }
    }
}


