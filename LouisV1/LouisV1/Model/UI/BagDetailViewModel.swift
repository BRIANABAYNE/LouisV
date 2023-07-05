//
//  BagDetailViewModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//

import FirebaseFirestore
import Foundation
import FirebaseFirestoreSwift
import FirebaseStorage


struct BagDetailViewModel {
    
    var bag: Bag?
    
    init(bag: Bag?) {
        self.bag = bag
    }
    
    // Cred functions
    func create(name: String, price: Double, season: String, location: String, gender: String, handler: @escaping(Result<String,FirebaseError>) -> Void) {
        let sizeDict = Size(small: "Is Small", medium: "Is Medium", large: "Is Large")
        let colors = [Color (colorName: "Black"), Color(colorName:"Pink"), Color(colorName:"White")]
        let bag = Bag(name: name, price: price, season: season, location: location, gender: gender, collectionType: "Bags", size: sizeDict, colors: colors)
        
        save(parameterBagName: bag) { result in
            switch result {
            case .success(let docID):
                handler(.success(docID))
            case .failure(let failure):
                print(failure)
            }
       
    }
        
    
    // Method singnature
        func save(parameterBagName: Bag, completion: @escaping (Result<String, FirebaseError>) -> Void) {
            let ref = Firestore.firestore()
            do {
                let documentRef = try ref.collection(Constatns.Bags.bagsCollectionPath).addDocument(from: parameterBagName, completion: { _ in
                })
                
                completion(.success(documentRef.documentID))
            } catch {
                print("Oh Shit. Something went wrong", error.localizedDescription)
                return
            }
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
    
    func saveImage(with image: UIImage, to docID: String) { // child is path to image per the docs 
        
        // Convert the image to data
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        // Build
        let storageRef = Storage.storage().reference()
        
        storageRef.child(Constatns.Images.imagePath).child(docID).putData(imageData) { metaData, error in
            if let error {
                print("Something went wrong")
                return
            }
            let imagePath = metaData?.path
            print(imagePath)
        }
    }
    
    
    }
