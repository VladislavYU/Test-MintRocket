//
//  RepositoriesTableViewController.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import UIKit

class RepositorysTableViewController: UITableViewController {

    var presenter: MainPresenter!
    
    let refresh = UIRefreshControl()
    
    init(with presenter: MainPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getListRepositories()
        
        
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
        return presenter.getCountRepositories()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell()
        let repository = presenter.getRepository(indexPath.row)
        
        cell.nameLabel.text = repository.name
        cell.idLabel.text = repository.id.description
        cell.loginLabel.text = repository.owner.login
        if repository.description != nil {
            cell.descriptionLabel.text = repository.description
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = presenter.getRepository(indexPath.row)
        let detailVC = DetailRepositoryViewController()
        detailVC.repository = repository
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = presenter.getLastNumberRepositories()
        if indexPath.row == lastItem {
            getListRepositories()
        }
    }
    
    
    @objc func refreshTableView(){
        presenter.getListRepositroriesWithoutSines {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
    
    func getListRepositories(){
        presenter.getListRepositories {
            self.tableView.reloadData()
        }
    }
 
 



}
