//
//  HorizontalPagingView.swift
//  mellow
//
//  Created by Tripp Gordon on 2/7/21.
//

import SwiftUI

struct HorizontalPagingView: View {
    
    let height: CGFloat
    
    var body: some View {
        
        TabView {
            ForEach(1...4, id: \.self) { count in
                Color(.black)
                    .frame(width: 200)
            }
            .frame(height: height)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
}

struct HorizontalPagingView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalPagingView(height: 100)
            .background(Color.red)
    }
}
