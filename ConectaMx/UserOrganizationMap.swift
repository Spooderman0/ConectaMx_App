//
//  UserOrganizationMap.swift
//  ConectaMx
//
//  Created by Danna Valencia on 17/10/23.
//

import SwiftUI
import MapKit

struct UserOrganizationMap: View {
    
    let organizations = [
        OrganizationMap(id: 1, name: "Paz es", coordinate: CLLocationCoordinate2D(latitude: 25.65066, longitude: -100.29356)),
        OrganizationMap(id: 2, name: "Effeta", coordinate: CLLocationCoordinate2D(latitude: 25.67566, longitude: -100.33826)),
        OrganizationMap(id: 2, name: "Vía Educación", coordinate: CLLocationCoordinate2D(latitude: 25.65247, longitude: -100.37267)),
        OrganizationMap(id: 2, name: "Ingenium", coordinate: CLLocationCoordinate2D(latitude: 25.65738, longitude: -100.39756)),
        OrganizationMap(id: 2, name: "Consejo Cívico", coordinate: CLLocationCoordinate2D(latitude: 25.65066, longitude: -100.2934)),
        OrganizationMap(id: 2, name: "Humind Care", coordinate: CLLocationCoordinate2D(latitude: 25.66439, longitude: -100.36805)),
        OrganizationMap(id: 2, name: "Nuevo Amanecer", coordinate: CLLocationCoordinate2D(latitude: 25.66474, longitude: -100.41323))
    ]
    
    var body: some View {
        MapView(organizations: organizations)
            .ignoresSafeArea()
    }
}

#Preview {
    UserOrganizationMap()
}
