//
//  RouteDetailView.swift
//  mellow
//
//  Created by Tripp Gordon on 1/26/21.
//

import SwiftUI




struct BottomSheetContentView: View {
    
    let height: CGFloat
    
    var body: some View {
//        // list
//        ScrollView(.horizontal, showsIndicators: false, content: {
//            LazyHStack(spacing: 15, content: {
//                ForEach(1...15, id: \.self) { count in
//                    Color(.black)
//                        .frame(width: 200)
//                }
//            })
//            //.padding()
//
//        })
//        .frame(height: height)
        
        let bottom_pad: CGFloat = 32
        
        HorizontalPagingView(height: height - bottom_pad)
        
        Spacer()
            
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContentView(height: 100)
    }
}
