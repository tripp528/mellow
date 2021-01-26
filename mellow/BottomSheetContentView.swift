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
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(alignment: .leading, spacing: 15, content: {
                ForEach(1...15, id: \.self) { count in
                    Text("Searched Place")
                    Divider()
                        .padding(.top,10)
                }
            })
            .padding()
            .padding(.top)
        })
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContentView()
    }
}
