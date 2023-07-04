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
        viewModel = BagListViewModel(injectedDelegate: BagListViewModelDelegate)
       // viewModel = BagListViewModel()
      //  viewModel.delegate = self // Hiring the delegate to do the job duties we need. 5
       // viewModel.fetchallBags()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.bagSourceOfTruth?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagCell", for: indexPath) as! BagTableViewCell
        let bag = viewModel.bagSourceOfTruth?[indexPath.row] 
        // Configure the cell... // will be doing this
        cell.configure(with: bag)
        
        return cell
    }
    
    
    
} /// end of VC

// Posting the open job 3
extension BagListTableViewController: BagListViewModelDelegate {
    // This job description 4
    func successfullyLoadedData() {
        DispatchQueue.main.async { // ON THE MAIN THREAD
            self.tableView.reloadData()
        }
    }
    
    
}
