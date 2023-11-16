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
    @IBOutlet weak var bagDisplayImageView: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: BagDetailViewModel!
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        configureView()
    }
    
    // MARK: - Methods
    private func configureView() {
        guard let bag = viewModel.bag else {return}
        bagNameLabel.text = bag.name
        bagPriceLabel.text = "\(bag.price)"
        bagSeasonLabel.text = bag.season
        bagLocationLabel.text = bag.location
        bagGenderLabel.text = bag.gender
        
        viewModel.fetchImage(with: bag.id)
    }
    private func setUpImageView () {
        bagDisplayImageView.isUserInteractionEnabled = true
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        bagDisplayImageView.addGestureRecognizer(tapGuesture)
    }
    @objc func imageViewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func addBagButtonTapped(_ sender: Any) {
        
        guard let name = bagNameLabel.text,
              let season = bagSeasonLabel.text,
              let price = bagPriceLabel.text,
              let location = bagLocationLabel.text,
              let gender = bagGenderLabel.text,
              let image = bagDisplayImageView.image else {return}
        
        let priceAsDouble = Double(price) ?? 0.0
        
        if viewModel.bag != nil {
            viewModel.updateBag(newName: name, newPrice: priceAsDouble, newSeason: season, newLocation: location, newGender: gender)
            viewModel.saveImage(with: image, to: (viewModel.bag?.id)!)
            
        } else {
            viewModel.create(name: name, price: priceAsDouble, season: season, location: location, gender: gender) { result in
                switch result {
                case .success(let docId):
                    self.viewModel.saveImage(with: image, to: docId)
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - Extension
extension BagDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        bagDisplayImageView.image = image
        picker.dismiss(animated: true)
    }
}

// MARK: - Extension

extension BagDetailViewController: BagDetailViewModelDelegate {
    func imageLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.bagDisplayImageView.image = self.viewModel.image
        }
    }
}
