//
//  BagListTableViewController.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/4/23.
//

import UIKit

class BagListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel: BagListViewModel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BagListViewModel(injectedDelegate: self)
    }
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchallBags()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.bagSourceOfTruth?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagCell", for: indexPath) as! BagTableViewCell
        let bag = viewModel.bagSourceOfTruth?[indexPath.row]
        cell.configure(with: bag)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BagDetailViewController else {return}
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let bag = viewModel.bagSourceOfTruth?[indexPath.row]
            destination.viewModel = BagDetailViewModel(bag: bag, injectedDelegate: destination )
        } else {
            
            destination.viewModel = BagDetailViewModel(bag: nil, injectedDelegate: destination)
        }
    }
}

// MARK: - Extension
extension BagListTableViewController: BagListViewModelDelegate {
    func successfullyLoadedData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
