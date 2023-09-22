//
//  MapView.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 19/09/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    // Variables de ejemplo
    var latitude: Double = 37.7749
    var longitude: Double = -122.4194

    func makeUIView(context: Context) -> MKMapView {
        // Crear un objeto MKMapView
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Configurar las coordenadas y la región del mapa
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }

    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Aquí puedes manejar eventos del mapa, si es necesario
    }
}
