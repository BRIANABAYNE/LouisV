//
//  BagDetailViewModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//

import FirebaseFirestore
import Foundation
import FirebaseFirestoreSwift


struct BagDetailViewModel {
    
    // Cred functions
    func create(name: String, price: Double, season: String, location: String, gender: String) {
        let sizeDict = Size(small: "Is Small", medium: "Is Medium", large: "Is Large")
        let colors = [Color (colorName: "Black"), Color(colorName:"Pink"), Color(colorName:"White")]
        let bag = Bag(name: name, price: price, season: season, location: location, gender: gender, collectionType: "Bags", size: sizeDict, colors: colors)
        
        save(parameterBagName: bag)
    }
    
    // Method singnature
    func save(parameterBagName: Bag) {
        let ref = Firestore.firestore()
        do {
            try ref.collection(parameterBagName.collectionType).addDocument(from: parameterBagName)
        } catch {
            print("Oh Shit. Something went wrong", error.localizedDescription)
            return
        }

    }
    
    // Fetch single bag
//    func fetch(parmeterdocID: String) {
//        let db = Firestore.firestore()
//        let path = db.collection("Bags").document(parmeterdocID)
//        path.getDocument(as:Bag.self) {result in
//            switch result {
//            case.success(let success):
//                print(success.name)
//            case.failure(let failure):
//                print("",failure.localizedDescription)
//            }
//        }
//
//
//    }
    
    func fetchallBags() {
        let db = Firestore.firestore()
        db.collection("Bags").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            do {
                let bagArray = try documents.compactMap({ try $0.data(as: Bag.self)})
                print(bagArray)
            } catch {
              
            }
        }
        
        } // end of fetch
    }