//
//  Home.swift
//  mellow
//
//  Created by Tripp Gordon on 1/24/21.
//

import SwiftUI
import MapKit


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MapWithSheet()
    }
}

struct MapWithSheet : View {
    
    @State var offset : CGFloat = 0
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            MapView()
                .edgesIgnoringSafeArea(.all)
            
            /// to read frame height...
            
            GeometryReader{reader in
                
                VStack{
                    
                    BottomSheet(offset: $offset, value: (-reader.frame(in: .global).height + 150))
                        .offset(y: reader.frame(in: .global).height - 140)
                        // adding gesture....
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({ (value) in
                            
                            withAnimation{
                                
                                // checking the direction of scroll....
                                
                                // scrolling upWards....
                                // using startLocation bcz translation will change when we drag up and down....
                                
                                if value.startLocation.y > reader.frame(in: .global).midX{
                                    
                                    if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + 150){
                                        
                                        offset = value.translation.height
                                    }
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX{
                                    
                                    if value.translation.height > 0 && offset < 0{
                                        
                                        offset = (-reader.frame(in: .global).height + 150) + value.translation.height
                                    }
                                }
                            }
                            
                        }).onEnded({ (value) in
                            
                            withAnimation{
                                
                                // checking and pulling up the screen...
                                
                                if value.startLocation.y > reader.frame(in: .global).midX{
                                    
                                    if -value.translation.height > reader.frame(in: .global).midX{
                                        
                                        offset = (-reader.frame(in: .global).height + 150)
                                        
                                        return
                                    }
                                    
                                    offset = 0
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX{
                                    
                                    if value.translation.height < reader.frame(in: .global).midX{
                                        
                                        offset = (-reader.frame(in: .global).height + 150)
                                        
                                        return
                                    }
                                    
                                    offset = 0
                                }
                            }
                        }))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        })
    }
}
