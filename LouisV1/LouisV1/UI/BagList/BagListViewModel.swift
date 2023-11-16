//
//  BagListViewModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/4/23.
//

import Foundation
import FirebaseFirestore


// MARK: - Protocol
protocol BagListViewModelDelegate: BagListTableViewController {
    func successfullyLoadedData()
}

class BagListViewModel {
    
    // MARK: - Properties
    var bagSourceOfTruth: [Bag]?
    weak var delegate: BagListViewModelDelegate?
    
    
    // MARK: - Dependency Injection
    init(injectedDelegate:BagListViewModelDelegate) {
        self.delegate = injectedDelegate
    }
        
        // MARK: - Functions
        
        func fetchallBags() {
            let db = Firestore.firestore()
            db.collection(Constatns.Bags.bagsCollectionPath).getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                
                do {
                    let bagArray = try documents.compactMap({ try $0.data(as: Bag.self)})
                    self.bagSourceOfTruth = bagArray
                    self.delegate?.successfullyLoadedData() // calling a function successfullyLoadedData
                    print(bagArray)
                } catch {
                    
                }
            }
            
        }
        
        func delete(indexPath: IndexPath) {
            let db = Firestore.firestore()
            guard let bag = bagSourceOfTruth?[indexPath.row]  else { return }
            db.collection(Constatns.Bags.bagsCollectionPath).document(bag.id!).delete(completion:nil)
            bagSourceOfTruth?.remove(at: indexPath.row)
        }
        
    
}
