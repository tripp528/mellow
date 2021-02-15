//
//  Home.swift
//  mellow
//
//  Created by Tripp Gordon on 1/24/21.
//

import SwiftUI
import MapKit

struct MapWithSheet : View {
    @State private var selected_annotation : MKAnnotation?
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            MapView(selected_annotation: $selected_annotation)
                .edgesIgnoringSafeArea(.top)
            
            BottomSheetWrapper(content_height: 300, selected_annotation: $selected_annotation)
                .edgesIgnoringSafeArea(.bottom)
        })
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MapWithSheet()
    }
}
