//
//  BoulderModel.swift
//  mellow
//
//  Created by Tripp Gordon on 2/15/21.
//

import Foundation
import Firebase


struct Boulder: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var location: GeoPoint

        
}
