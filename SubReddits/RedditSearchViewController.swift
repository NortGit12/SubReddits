//
//  RedditSearchViewController.swift
//  SubReddits
//
//  Created by Jeff Norton on 8/29/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class RedditSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    @IBOutlet weak var searchTermTextField: UITextField!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var resultsTextView: UITextView!
    var tableData = []
    
    //==================================================
    // MARK: - General
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //==================================================
    // MARK: - UITableViewDataSource
    //==================================================
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath)
        
//        let redditEntry: NSMutableDictionary = self.tableData[indexPath.row] as NSMutableDictionary
//        
//        cell.textLabel?.text = redditEntry["data"]!["title"] as String
//        cell.detailTextLabel?.text = redditEntry["data"]!["author"] as String

        return cell
    }
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    //==================================================
    // MARK: - Action(s)
    //==================================================
    
    @IBAction func searchButtonTapped(sender: UIButton) {
        
        guard let searchTerm = searchTermTextField.text where searchTerm.characters.count > 0 else { return }
        
        RedditModelController.getSubReddits(searchTerm) { (resultsDict) in
            
            // TODO: Implement getting the results and populating tableData
        }
        
        resultsTextView.text = ":)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
