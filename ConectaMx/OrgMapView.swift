//
//  OrgMapView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 10/10/23.
//

import SwiftUI
import MapKit

func getCoordinate(addressString : String,
                   completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                completionHandler(location.coordinate, nil)
                return
            }
        }
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}

struct OrganizationMap: Identifiable {
    let id: Int
    let name: String
    var coordinate: CLLocationCoordinate2D
}

struct OrgMapView: View {
    @State private var organizations: [OrganizationMap] = [
        OrganizationMap(id: 1, name: "Organización 1", coordinate: kCLLocationCoordinate2DInvalid),
        OrganizationMap(id: 2, name: "Organización 2", coordinate: kCLLocationCoordinate2DInvalid),
        OrganizationMap(id: 3, name: "Organización 3", coordinate: kCLLocationCoordinate2DInvalid)
    ]

    let addresses = [
        "Avenida Eugenio Garza Sada 2411, Tecnologico, 64700 Monterrey, N.L., México",
        "Eugenio Garza Sada 2501, Tecnologico, 64840 Monterrey, NL, México",
        "Técnicos 202, Tecnologico, 64700 Monterrey, N.L., México"
    ]
    
    var body: some View {
        Map {
            ForEach(organizations) { organization in
                if CLLocationCoordinate2DIsValid(organization.coordinate) {
                    Marker(organization.name, coordinate: organization.coordinate)
                }
            }
        }
        .onAppear {
            loadCoordinates()
        }
    }

    func loadCoordinates() {
        for (index, address) in addresses.enumerated() {
            getCoordinate(addressString: address) { (coordinate, error) in
                if let error = error {
                    print("Error geocoding address: \(error)")
                } else {
                    organizations[index].coordinate = coordinate
                }
            }
        }
    }
}

struct OrgMapView_Previews: PreviewProvider {
    static var previews: some View {
        OrgMapView()
    }
}
