//
//  BoulderPreview.swift
//  mellow
//
//  Created by Tripp Gordon on 2/15/21.
//

import SwiftUI

struct BoulderPreview: View {
    
    let width: CGFloat
    let height: CGFloat
    let text: String
    
    var body: some View {
        ZStack {
            Text("\(text)")
                .frame(width: self.width, height: self.height)
                .background(Color.blue)
        }
    }
}

struct BoulderPreview_Previews: PreviewProvider {
    static var previews: some View {
        BoulderPreview(width: 300, height: 300, text: "HI")
    }
}
