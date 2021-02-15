//
//  BottomSheetWrapper2.swift
//  mellow
//
//  Created by Tripp Gordon on 1/25/21.
//

import SwiftUI
import MapKit

struct BottomSheetWrapper: View {
    
    // params
    let handle_height : CGFloat
    let content_height : CGFloat
    
    // bound params
    @Binding var selected_annotation : MKAnnotation?
    
    // derived vars
    let midpoint : CGFloat
    let top_position_offset : CGFloat
    let bottom_position_offset : CGFloat
    
    // state vars
    @State private var offset: CGSize = .zero
    @State private var position_offset : CGFloat = 0
    @State private var is_open: Bool = false
    
    init(handle_height : CGFloat = 50,
         content_height : CGFloat = 300,
         selected_annotation : Binding<MKAnnotation?> = .constant(nil)
    ) {
        // params
        self.handle_height = handle_height
        self.content_height = content_height
        _selected_annotation = selected_annotation
        
        // derived vars
        self.midpoint = content_height / 2
        self.top_position_offset = -content_height
        self.bottom_position_offset = 0
        
        // set initial state
        self.close()
    }
    
    func snap() -> Void {
        print("Snapping... \(self.position_offset)")
        self.offset.height = self.position_offset
    }
    
    func set_is_open(_ new_is_open: Bool) -> Void {
        self.is_open = new_is_open
        if (self.is_open) {
            self.position_offset = self.top_position_offset
        } else {
            self.position_offset = self.bottom_position_offset
        }
    }
    
    func open() -> Void {
        self.set_is_open(true)
        self.snap()
    }
    func close() -> Void {
        self.set_is_open(false)
        self.snap()
    }
    
    var body: some View {
        GeometryReader { geo in
            
            
            // Y pixel values are greater as you move down!!
            VStack {
                let screen_height = geo.frame(in: .global).height
                let total_beginning_offset = screen_height - self.handle_height
                
                BottomSheet(handle_height: self.handle_height,
                            content_height: self.content_height,
                            selected_annotation: $selected_annotation
                )
                .frame(alignment: .center)
                
                
                // at the start, we offset the whole sheet down by the height of the screen
                // then, we offset it back up by the height of the handle
                .offset(y: total_beginning_offset)
                .offset(self.offset)
                
                .gesture(DragGesture().onChanged({ (value) in
                    
                    // Gesture is happening! Move it with finger - unless above or below top / bottom.
                    self.offset.height = self.position_offset + value.translation.height
                    
                }).onEnded({ (value) in
                    withAnimation {
                        // change position if gesture was large enough
                        if (value.translation.height < -50) {
                            self.set_is_open(true)
                        }
                        if (value.translation.height > 50) {
                            self.set_is_open(false)
                        }
                        
                        // snap to whatever state it is in
                        self.snap()
                    }
                }))
            }
        }
    }
}

struct BottomSheetWrapper2_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetWrapper()
            .ignoresSafeArea(.all, edges: .bottom)
    }
}
