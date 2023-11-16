//
//  BagTableViewCell.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/4/23.
//

import UIKit

class BagTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var bagNameLabel: UILabel!
    @IBOutlet weak var bagPriceLabel: UILabel!
    @IBOutlet weak var bagGenderLabel: UILabel!
    
    // MARK: - Method
    func configure(with bag: Bag?) {
        guard let bag = bag else { return } // We are
        bagNameLabel.text = bag.name
        bagPriceLabel.text = "\(bag.price)"
        bagGenderLabel.text = bag.gender
    }
}
