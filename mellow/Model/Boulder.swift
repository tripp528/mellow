//
//  BoulderModel.swift
//  mellow
//
//  Created by Tripp Gordon on 2/15/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Boulder: Identifiable, Codable {
    
    
    // to map the id property to the documentID in Firestore, use @DocumentID
    @DocumentID var id: String? = UUID().uuidString
    
    var name: String
    var location: GeoPoint

    
    /*
        Codable means that attribute names here must be the same as in firestore
        if they are not, you need the CodingKeys
     
        e.g.
     
        enum CodingKeys: String, CodingKey {
            case name
            case location = "boulderLocation" // if it was boulderLocation in Firestore
        }
    */
}
