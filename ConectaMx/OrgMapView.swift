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

    init(calle: String, numero: String, colonia: String, cp: String, ciudad: String, estado: String, pais: String) {
        self.address = "\(calle) \(numero), \(colonia), \(cp), \(ciudad), \(estado), \(pais)"
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
        OrgMapView(calle:"Avenida Eugenio Garza Sada", numero: "2411", colonia: "Tecnologico", cp:"64700", ciudad: "Monterrey", estado: "N.L.", pais: "México")
    }
}

/*
 OrgMapView(calle: .constant("Avenida Eugenio Garza Sada"), numero: .constant("2411"), colonia: .constant("Tecnologico"), cp: .constant("64700"), ciudad: .constant("Monterrey"), estado: .constant("N.L."), pais: .constant("México"))
 */
