//
//  BoulderListView.swift
//  mellow
//
//  Created by Tripp Gordon on 2/15/21.
//

import SwiftUI
import Firebase


struct BoulderListView: View {
    
    // add a viewmodel that is subscribed to firestore documents, and is observable
    // @ObservedObject indicates that this view gets updated based on property changes to viewModel
    // Like an "Extension" of state to an outside object, to separate out some of the logic that would clog up this file.
    @ObservedObject private var viewModel = BouldersViewModel()
    
    
    var body: some View {
        NavigationView {
            List(viewModel.boulders) { boulder in
                VStack {
                    Text(boulder.name)
                    Text(String(boulder.location.latitude))
                    Text(String(boulder.location.longitude))
                }
            }
            
            // we need to make sure that the fetchData method of our viewModel is called
            // so that we are subscribed to firebase boulders collection
            .onAppear() {
                self.viewModel.addBouldersCollectionListener()
            }
        }
    }
}

struct BoulderListView_Previews: PreviewProvider {
    static var previews: some View {
        BoulderListView()
    }
}
