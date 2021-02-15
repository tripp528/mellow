//
//  MapView.swift
//  Landmarks
//
//  Created by Tripp Gordon on 1/20/21.
//  Copyright © 2021 mellow. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var selected_annotation : MKAnnotation?
    
    class Coordinator: NSObject, MKMapViewDelegate {
        // delegate of the map. gets notified when any events happen on the map.
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // function to notify when user taps on annotation
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            //print("annotation, \(view.annotation)")
            self.parent.selected_annotation = view.annotation
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            self.parent.selected_annotation = nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .satellite
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13), latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.region = region
        
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)
        
    
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//            .edgesIgnoringSafeArea(.all)
//    }
//}
