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
                //BottomSheet(offset: $offset, value: (-reader.frame(in: .global).height + 150))
                BottomSheet()
                    .offset(y: geo.frame(in: .global).height - self.minHeight)
                    // adding gesture....
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        // value is the pixel value of where your finger is when dragging??
                        // but also has translation property?
                        withAnimation{
                            // checking the direction of scroll....
                            // scrolling upWards....
                            // using startLocation bcz translation will change when we drag up and down....
                            
                            if value.startLocation.y > geo.frame(in: .global).midX{
                                if value.translation.height < 0 && offset > (-geo.frame(in: .global).height + 150){
                                    offset = value.translation.height
                                }
                            }
                            
                            if value.startLocation.y < geo.frame(in: .global).midX {
                                if value.translation.height > 0 && offset < 0 {
                                    offset = (-geo.frame(in: .global).height + 150) + value.translation.height
                                }
                            }
                        }
                        // this is onChanged onEnded. so when the finger is lifted
                    }).onEnded({ (value) in
                        withAnimation {
                            
                            // determine which way to pull the thing - to top or to bottom
                            
                            // checking and pulling up the screen...
                            if value.startLocation.y > geo.frame(in: .global).midX {
                                if -value.translation.height > geo.frame(in: .global).midX {
                                    offset = (-geo.frame(in: .global).height + 150)
                                    return
                                }
                                offset = 0
                            }
                            
                            if value.startLocation.y < geo.frame(in: .global).midX {
                                if value.translation.height < geo.frame(in: .global).midX {
                                    offset = (-geo.frame(in: .global).height + 150)
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
