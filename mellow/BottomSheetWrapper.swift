//
//  BottomSheetWrapper.swift
//  mellow
//
//  Created by Tripp Gordon on 1/25/21.
//

import SwiftUI

struct BottomSheetWrapper: View {
    
    @State var offset : CGFloat = 0
    
    let handle_height : CGFloat
    let content_height : CGFloat
    let midpoint : CGFloat
    let top_position_offset : CGFloat
    let bottom_position_offset : CGFloat = 0
    
    
    init(handle_height : CGFloat = 50,
         content_height : CGFloat = 300
         
         ) {
        // TODO: take params for these
        self.handle_height = handle_height
        self.content_height = content_height
        midpoint = content_height / 2
        top_position_offset = -content_height
        
        offset = bottom_position_offset
    }
    
    var body: some View {
        GeometryReader { geo in
            // Y pixel values are greater as you move down!!
            VStack {
                let screen_height = geo.frame(in: .global).height
                let total_beginning_offset = screen_height - self.handle_height
 
                // let midpoint = geo.frame(in: .global).midX
                
                
                
                //BottomSheet(offset: $offset, value: (-reader.frame(in: .global).height + 150))
                BottomSheet(handle_height: self.handle_height, content_height: self.content_height)
                    
                    /*
                     at the start, we offset the whole sheet down by the height of the screen
                     then, we offset it back up by the height of the handle
                     */
                    .offset(y: total_beginning_offset)
                    
                    /*
                     from here on out, the value of offset will be negative
                     
                        0                   = position with just the handle showing
                        (-content_height)   = position with all content showing
                     
                     */
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        let gesture_start = value.startLocation.y
                        
                        /*
                         all offsets are in relation to the top of the padding of the handle!
                         */
                        
                        /*
                         gesture_start_offset will be 0 at top of handle area when closed
                         around content_height at top of handle area when open
                         */
                        let gesture_start_offset = total_beginning_offset - gesture_start
                        let distance_dragged = value.translation.height
                        
                        // Gesture is happening! Move it with finger - unless above or below top / bottom.
                        
                        withAnimation {
                            
                            // if started at bottom
                            if gesture_start_offset < midpoint {
                                offset = bottom_position_offset + distance_dragged
                            }

                            // if started at top
                            if gesture_start_offset >= midpoint {
                                offset = top_position_offset + distance_dragged
                            }
                            
                            // if offset goes more negative than top position
                            if offset < top_position_offset {
                                offset = top_position_offset + (distance_dragged / 10)
                            }
                            
                            // if offset gets larger than bottom position
                            if offset > bottom_position_offset {
                                offset = bottom_position_offset + (distance_dragged / 10)
                            }
                        }
                        
                    }).onEnded({ (value) in
                        
                        withAnimation {
                            // Gesture is ended! Snap to top or bottom
                            if (-offset) > midpoint {
                                offset = top_position_offset
                            } else if (-offset) <= midpoint {
                                offset = bottom_position_offset
                            }
                        }
                    }))
            }
        }
    }
}

struct BottomSheetWrapper_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetWrapper()
            .ignoresSafeArea(.all, edges: .bottom)
    }
}
