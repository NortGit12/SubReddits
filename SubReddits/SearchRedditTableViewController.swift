//
//  SearchRedditTableViewController.swift
//  SubReddits
//
//  Created by Jeff Norton on 8/29/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class SearchRedditTableViewController: UITableViewController, UISearchBarDelegate {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tableData = [String]()
    
    //==================================================
    // MARK: - General
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    //==================================================
    // MARK: - Table view data source
    //==================================================

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("subRedditTitleCell", forIndexPath: indexPath)

        let title = self.tableData[indexPath.row]
        
        cell.textLabel?.text = title

        return cell
    }
    
    //==================================================
    // MARK: - Method(s)
    //==================================================
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text where searchText.characters.count > 0 else { return }
        
        searchBar.endEditing(true)
        
        RedditModelController.getSubReddits(searchText) { (results) in
            
            if let results = results {
                self.tableData = results
                self.tableView.reloadData()
            }
        }
    }

}
