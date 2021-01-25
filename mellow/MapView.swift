//
//  MapView.swift
//  mellow
//
//  Created by Tripp Gordon on 1/24/21.
//

import SwiftUI
import Mapbox

struct MapView: UIViewRepresentable {
    private let mapView: MGLMapView = MGLMapView(frame: .zero, styleURL: MGLStyle.streetsStyleURL)

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MGLMapView {
        return mapView
    }

    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapView>) {

    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
