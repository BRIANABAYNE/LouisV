//
//  BagListViewModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/4/23.
//

import Foundation
import FirebaseFirestore


// Creating a job posting 1
protocol BagListViewModelDelegate: BagListTableViewController {
    func successfullyLoadedData()
    
}

class BagListViewModel {
    
   
    
    // MARK: - Property
    var bagSourceOfTruth: [Bag]?
    // Actual job req. This is their employee number when the are hired 2
    weak var delegate: BagListViewModelDelegate?
    
    
    // Dependency Injection - Why? To make our code easier to test. /// This is being called 3rd. from the viewmodel bag. The injected delegate, When it get triggered it will then trigger the body.
    init(injectedDelegate:BagListViewModelDelegate) {
        self.delegate = injectedDelegate // hiring the person
        //fetchallBags() // duty of the person hired  /// This is calling the fetch all bags and will start to trigger the first libe in the fetchAll bags
    }
    
    // Goal - fetch all bags
    
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
        
    } // fetch all bags
    
    // can name if whatever you want inside of the peramters
//    func delete(bag: Bag ) {
//        let db = Firestore.firestore() // need this to get access to the data base
//        db.collection(Constatns.Bags.bagsCollectionPath).document(bag.id!).delete(completion:nil)
//        let index = bagSourceOfTruth.index
//        self.bagSourceOfTruth?.remove(at: <#T##Int#>)
//        } // ! force unwrapping with ! becasue it said it need to be unwrapped.
//
        
    
    func delete(indexPath: IndexPath) {
        let db = Firestore.firestore()
        guard let bag = bagSourceOfTruth?[indexPath.row]  else { return }
        db.collection(Constatns.Bags.bagsCollectionPath).document(bag.id!).delete(completion:nil)
        bagSourceOfTruth?.remove(at: indexPath.row)
    }
    
    
    
    
        
    } // ending func delete
    
    
    
 // end of class
