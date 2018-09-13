//
//  RepositoriesTableViewController.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import UIKit

class RepositorysTableViewController: UITableViewController {

    var repositories: [RepositoryModel] = []
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getList(sines: nil)
        
        
        refresh.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refresh
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell()
        let repository = repositories[indexPath.row]
        
        cell.nameLabel.text = repository.name
        cell.idLabel.text = repository.id.description
        cell.loginLabel.text = repository.owner.login
        if repository.description != nil {
            cell.descriptionLabel.text = repository.description
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let detailVC = DetailRepositoryViewController()
        detailVC.repository = repository
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = repositories.count - 1
        let lastItemId = repositories[indexPath.row].id
        if indexPath.row == lastItem {
            getList(sines: lastItemId)
        }
    }
    
    
    @objc func refreshTableView(){
        getList(sines: nil)
    }
    
    func getList(sines: Int?){
        Api.shared.getRepositories(sines: sines) { (repositories) in
            self.repositories = self.repositories + repositories
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
 
 



}
