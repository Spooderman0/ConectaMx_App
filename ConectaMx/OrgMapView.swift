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
    @State private var organization: OrganizationMap = OrganizationMap(id: 1, name: "Organización", coordinate: kCLLocationCoordinate2DInvalid)
    
    let address: String

    // El inicializador ahora simplemente acepta la dirección completa
    init(address: String) {
        self.address = address
    }
    
    var body: some View {
        Map {
            if CLLocationCoordinate2DIsValid(organization.coordinate) {
                Marker(organization.name, coordinate: organization.coordinate)
            }
        }
        .onAppear {
            loadCoordinate()
        }
    }

    func loadCoordinate() {
        getCoordinate(addressString: address) { (coordinate, error) in
            if let error = error {
                print("Error geocoding address: \(error)")
            } else {
                organization.coordinate = coordinate
            }
        }
    }
}

struct OrgMapView_Previews: PreviewProvider {
    static var previews: some View {
        OrgMapView(address: "Avenida Eugenio Garza Sada 2411, Tecnologico, 64700 Monterrey, N.L., México")
    }
}
