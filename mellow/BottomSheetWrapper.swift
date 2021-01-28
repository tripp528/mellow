//
//  BottomSheetWrapper.swift
//  mellow
//
//  Created by Tripp Gordon on 1/25/21.
//

import SwiftUI

struct BottomSheetWrapper: View {
    @State var offset : CGFloat = 0
    
    let minHeight : CGFloat = 50
    
    var body: some View {
        /// to read frame height...
        GeometryReader { geo in
            
            VStack {
                
                let midpoint = geo.frame(in: .global).midX
                let max_height = geo.frame(in: .global).height
                
                //BottomSheet(offset: $offset, value: (-reader.frame(in: .global).height + 150))
                BottomSheet()
                    .offset(y: geo.frame(in: .global).height - self.minHeight)
                    // adding gesture....
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        
                        // get gesture start and distance
                        let gesture_start = value.startLocation.y
                        let distance_dragged = value.translation.height
                        print("gesture_start: \(gesture_start)")
                        print("distance_dragged: \(distance_dragged)")
                        print("midpoint: \(midpoint)")
                        print("max_height: \(max_height)")
                        print("offset: \(offset) \n\n")
                        
                        withAnimation{
                            // checking the direction of scroll....
                            // scrolling upWards....
                            // using startLocation bcz translation will change when we drag up and down....
                            
                            if gesture_start > midpoint {
                                if distance_dragged < 0 && offset > (-max_height + 150){
                                    offset = distance_dragged
                                }
                            }
                            
                            if gesture_start < midpoint {
                                // if
                                if distance_dragged > 0 && offset < 0 {
                                    offset = (-max_height + 150) + distance_dragged
                                }
                            }
                        }
                        // this is onChanged onEnded. so when the finger is lifted
                    }).onEnded({ (value) in
                        
                        // get gesture start and distance again. now that gesture is over.
                        let gesture_start = value.startLocation.y
                        let distance_dragged = value.translation.height
                        
                        // print out values
                        print("gesture_start: \(gesture_start)")
                        print("distance_dragged: \(distance_dragged)")
                        print("midpoint: \(midpoint)")
                        print("max_height: \(max_height)")
                        print("offset: \(offset) \n\n")
                        
                        withAnimation {
                            
                            // determine which way to pull the thing - to top or to bottom
                            
                            // checking and pulling up the screen...
                            if gesture_start > midpoint {
                                if -distance_dragged > midpoint {
                                    offset = (-max_height + 150)
                                    return
                                }
                                offset = 0
                            }
                            
                            if gesture_start < midpoint {
                                if distance_dragged < midpoint {
                                    offset = (-max_height + 150)
                                    return
                                }
                                offset = 0
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
