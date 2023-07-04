//
//  BagDetailViewController.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//
import FirebaseFirestore
import UIKit

class BagDetailViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var bagNameLabel: UITextField!
    @IBOutlet weak var bagSeasonLabel: UITextField!
    @IBOutlet weak var bagPriceLabel: UITextField!
    @IBOutlet weak var bagLocationLabel: UITextField!
    @IBOutlet weak var bagGenderLabel: UITextField!
    @IBOutlet weak var saveBagButton: UIButton!
    
    // MARK: - Prperty
    
    // This is place holder
    var viewModel: BagDetailViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // calling 
        viewModel = BagDetailViewModel()
        viewModel.fetchallBags() // Testing but will want to delete 
    }
    

// MARK: - Actions
    
    
    @IBAction func addBagButtonTapped(_ sender: Any) {
        
        
        // Reading the data
        guard let name = bagNameLabel.text,
        let season = bagSeasonLabel.text,
        let price = bagPriceLabel.text,
        let location = bagLocationLabel.text,
        let gender = bagGenderLabel.text else {return}
        
        
        // Nil - Coalecing to unrwap the double
        let priceAsDouble = Double(price) ?? 0.0
        
        viewModel.create(name: name, price: priceAsDouble, season: season, location: location, gender: gender)
        
    }
    
} // end of the VC


