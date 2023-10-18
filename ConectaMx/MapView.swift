//
//  MapView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 19/09/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
   
    var latitude: Double = 37.7749
    var longitude: Double = -122.4194

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
        // Muestra la ubicación del usuario
        uiView.showsUserLocation = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapView
        var locationManager = CLLocationManager()

        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.locationManager.delegate = self
        }

        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if manager.authorizationStatus == .authorizedWhenInUse {
                locationManager.requestLocation() // Solicita la ubicación una vez
            } else if manager.authorizationStatus == .notDetermined {
                locationManager.requestWhenInUseAuthorization() // Solicita permiso
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // Maneja la ubicación actualizada si es necesario
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            // Maneja errores
        }
    }
}

