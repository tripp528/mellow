//
//  RouteDetailView.swift
//  mellow
//
//  Created by Tripp Gordon on 1/26/21.
//

import SwiftUI




struct BottomSheetContentView: View {
    var body: some View {
        // list
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 15, content: {
                ForEach(1...15, id: \.self) { count in
                    Rectangle()
                        .frame(width: 200)
                }
            })
            .padding()
            .padding(.top)
            
        })
        .frame(height: 500)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContentView()
    }
}
