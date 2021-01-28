//
//  Home.swift
//  mellow
//
//  Created by Tripp Gordon on 1/24/21.
//

import SwiftUI
import MapKit

struct MapWithSheet : View {
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            MapView()
                .edgesIgnoringSafeArea(.top)
            
            BottomSheetWrapper()
                .edgesIgnoringSafeArea(.bottom)
        })
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MapWithSheet()
    }
}
