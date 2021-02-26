//
//  BoulderViewModel.swift
//  mellow
//
//  Created by Tripp Gordon on 2/25/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class BouldersViewModel: ObservableObject {
    // main responsibility of the class is to hold a collection of Boulders
    
    // ObservableObject allows the UI to update itself with properties of this object as if it was its own state!
    
    // mark any properties that need to be observed by the UI as @Published
    @Published var boulders = [Boulder]()
    
    private var db = Firestore.firestore()
    
    func addBoulder(boulder: Boulder) {
        do {
            let _ = try db.collection("boulders").addDocument(from: boulder)
        }
        catch {
            print(error)
        }
        
    }
    
    func addBouldersCollectionListener() {
        db.collection("boulders").addSnapshotListener { (querySnapshot, error) in
            
            // querySnapshot holds the documents from our collection (optional)
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // compactMap unwraps any optionals and discards all nil values
            self.boulders = documents.compactMap({ (queryDocumentSnapshot) -> Boulder? in
                return try? queryDocumentSnapshot.data(as: Boulder.self)
            })
        }
    }
}


/* the following code is less than ideal!
        - makes assumptions about structure of data
        - what happens if we add an attribute to boulder?
    
 this is the problem that Codeable resolves!

// transform the documents into boulder model objects
self.boulders = documents.map { (queryDocumentSnapshot) -> Boulder in
    // each queryDocumentSnapshot represents one document
    
    // queryDocumentSnapshot.data() is a dictionary mapping from [ string : any ]. This corresponds to [ attribute name : value ] in firestore
    let data = queryDocumentSnapshot.data()
    
    // unpack each field and typecast to proper type (with defaults) so swift doesn't complain
    let name = data["name"] as? String ?? ""
    let location = data["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
    
    // create the boulder object and return
    return Boulder(name: name, location: location)
}
 
*/
