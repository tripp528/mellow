//
//  HorizontalPagingView2.swift
//  mellow
//
//  Created by Tripp Gordon on 2/7/21.
//

import SwiftUI

struct HorizontalPagingView: View {
    
    // params
    let image_width: CGFloat = 300
    let height: CGFloat
    let hidden_card_width_showing: CGFloat
    let spacing: CGFloat
    let n_items: Int
    
    // derived vars
    let card_width: CGFloat
    let total_spacing: CGFloat
    let total_canvas_width: CGFloat
    let left_padding: CGFloat
    let init_offset: CGFloat
    
    // state vars
    @State private var offset: CGSize = .zero
    @State private var active_index: Int = 0
    @State private var index_offset: CGFloat = 0
    
    init (height: CGFloat,
          hidden_card_width_showing: CGFloat = 32,
          spacing: CGFloat = 16,
          n_items: Int = 3
    ) {
        // params
        self.height = height
        self.hidden_card_width_showing = hidden_card_width_showing
        self.spacing = spacing
        self.n_items = n_items
        
        // derived vars
        self.card_width = UIScreen.main.bounds.width - (self.hidden_card_width_showing*2) - (self.spacing*2)
        self.total_spacing = CGFloat((self.n_items - 1)) * self.spacing
        self.total_canvas_width = (self.card_width * CGFloat(self.n_items)) + CGFloat(self.total_spacing)
        self.left_padding = self.hidden_card_width_showing + self.spacing
        self.init_offset = (self.total_canvas_width - UIScreen.main.bounds.width) / 2 + self.left_padding
    }
    
    func set_active_index(new_index: Int) -> Void {
        if (new_index > -1 && new_index < self.n_items) {
            self.active_index = new_index
        }
        self.index_offset = CGFloat(self.active_index) * (self.card_width + self.spacing)
    }
    
    func snap() -> Void {
        // "snap"
        withAnimation {
            self.offset.width = -self.index_offset
        }
    }
    
    
    var body: some View {
        
        HStack (alignment: .center, spacing: spacing) {
            ForEach(1...n_items, id: \.self) { count in
                BoulderPreview(width: 300, height: self.height, text: "asdf")
                    .frame(width: card_width)
            }
        }
        .offset(x: init_offset)
        .offset(self.offset)
        .gesture(
            DragGesture()
                .onChanged { val in
                    self.offset.width = val.translation.width - self.index_offset
                }
                .onEnded { val in
                    // increment left
                    if (val.translation.width < -50) {
                        self.set_active_index(new_index: self.active_index + 1)
                    }
                    // increment right
                    if (val.translation.width > 50) {
                        self.set_active_index(new_index: self.active_index - 1)
                    }
                    self.snap()
                }
        )
    }
    
    
}

struct HorizontalPagingView2_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalPagingView(height: 100)
            .background(Color.red)
    }
}
