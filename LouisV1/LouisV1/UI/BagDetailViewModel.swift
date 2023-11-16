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


// MARK: - Protocol
protocol BagDetailViewModelDelegate: AnyObject {
    func imageLoadedSuccessfully()
}


class BagDetailViewModel {
    
    // MARK: - Properties
    var bag: Bag?
    var image: UIImage?
    weak var delegate: BagDetailViewModelDelegate?
    
    // MARK: - Depdency Injection
    init(bag: Bag?, injectedDelegate: BagDetailViewModelDelegate) {
        self.bag = bag
        self.delegate = injectedDelegate
        self.fetchImage(with: bag?.id)
    }
    
    // MARK: - Functions
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
    }
    
    func save(parameterBagName: Bag, completion: @escaping (Result<String, FirebaseError>) -> Void) { // conceting image to data
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
    
    func fetchImage(with id: String?) {
        guard let id else { return }
        let storageRef = Storage.storage().reference()
        
        storageRef.child(Constatns.Images.imagePath).child(id).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case.success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                self.image = image
                self.delegate?.imageLoadedSuccessfully()
            case.failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    func saveImage(with image: UIImage, to docID: String) {
        
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        
        let storageRef = Storage.storage().reference()
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.child(Constatns.Images.imagePath).child(docID).putData(imageData, metadata: uploadMetadata) { result in
            switch result {
            case .success(let metaData):
                let imagePath = metaData.path
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    func updateBag( newName: String, newPrice: Double, newSeason: String, newLocation: String, newGender: String) {
        
        
        guard let bagToUPdate = self.bag else {return}
        let updateBag = Bag(id: bagToUPdate.id, name: newName, price: newPrice, season: newSeason, location: newLocation, gender: newGender, collectionType: Constatns.Bags.bagsCollectionPath, size: bagToUPdate.size, colors: bagToUPdate.colors)
        
        update(bag: updateBag)
        
    }
    
    func update(bag: Bag) {
        if let documentID = bag.id {
            let ref = Firestore.firestore()
            let docref = ref.collection(Constatns.Bags.bagsCollectionPath).document(documentID) // collection, document, collection , document
            
            do {
                try docref.setData(from: bag)
            } catch {
                print(error)
                
            }
            
        }
        
    }
}

func fetch(parmeterdocID: String) {
    let db = Firestore.firestore()
    let path = db.collection("Bags").document(parmeterdocID)
    path.getDocument(as:Bag.self) { result in
        switch result {
        case.success(let success):
            print(success.name)
        case.failure(let failure):
            print("",failure.localizedDescription)
        }
    }
}
