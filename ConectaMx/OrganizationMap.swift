//
//  OrganizationMap.swift
//  ConectaMx
//
//  Created by Danna Valencia on 17/10/23.
//

import Foundation
import MapKit


struct OrganizationMap: Identifiable {
    let id: Int
    let name: String
    var coordinate: CLLocationCoordinate2D
}
