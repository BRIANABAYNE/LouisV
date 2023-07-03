//
//  BagDetailViewController.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//

import UIKit

class BagDetailViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var bagNameLabel: UITextField!
    
    @IBOutlet weak var bagSeasonLabel: UITextField!
    
    @IBOutlet weak var bagPriceLabel: UITextField!
    
    @IBOutlet weak var bagLocationLabel: UITextField!
    
    @IBOutlet weak var bagGenderLabel: UITextField!
    
    
    @IBOutlet weak var saveBagButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

// MARK: - Actions
    
    
    @IBAction func addBagButtonTapped(_ sender: Any) {
    }
    
} // end of the VC 



