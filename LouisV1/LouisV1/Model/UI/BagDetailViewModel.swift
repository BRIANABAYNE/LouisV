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

protocol BagDetailViewModelDelegate: BagDetailViewController {
    func imageLoadedSuccessfully() 
}


class BagDetailViewModel {
    
    var bag: Bag?
    var image: UIImage?
    weak var delegate: BagListViewModelDelegate?
    
    init(bag: Bag?, injectedDelegate: BagDetailViewModelDelegate) {
        self.bag = bag
        self.delegate = injectedDelegate
        self.fetchImage(with: bag?.id)
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
        } // end of the save
        
        func fetchImage(with id: String) {
            guard let id else { return }
            let storageRef = Storage.storage().reference()
            
              storageRef.child(Constatns.Images.imagePath).child(id).getData(maxSize: 1024 * 1024) { result in
                switch result {
                case.success(let imageData):
                    guard let image = UIImage(data: imageData) else { return }
                    self.image = image
                case.failure(let failure):
                    print(failure.localizedDescription)
            }
                
            }
            // where are we trying to fetch the image from
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
