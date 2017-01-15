//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

fileprivate let reuseIden = "BusinessCell"

class BusinessesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    var mapBtn: UIBarButtonItem?
    
    var businesses: [Business]?
    var searchBar = UISearchBar()
    var isLoadingData = false
    var searchTerm: String = ""
    
    @IBOutlet weak var loadingFooterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //search bar set up
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search for bussiness"
        self.navigationItem.titleView = self.searchBar
        self.searchBar.tintColor = UIColor.black
        
        //set map btn
        setMapBtn()
        
        //perform fetch
        self.searchTerm = "Bars"
        activityIndicator.startAnimating()
        Business.searchWithTerm(term: self.searchTerm, offset:nil, limit:nil,  completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            DispatchQueue.main.async {
                self.containerView.isHidden = true
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        })
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMapBtn(){
        self.mapBtn = UIBarButtonItem()
        self.mapBtn?.title = "Map"
        self.mapBtn?.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = self.mapBtn
    }
    
    func loadMoreEntries(){
        Business.searchWithTerm(term: self.searchTerm, offset: self.businesses?.count, limit: nil) { (businesses, error) in
            if let newBusinesses = businesses, newBusinesses.count > 0{
                self.isLoadingData = false
                self.businesses?.append(contentsOf: newBusinesses)
                DispatchQueue.main.async {
                    self.containerView.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }else{
                self.loadingFooterView.isHidden = true
            }

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(!self.isLoadingData){
            if(scrollView.contentOffset.y > scrollView.contentSize.height - self.view.frame.size.height){
                self.isLoadingData = true
                self.loadMoreEntries()
            }
        }
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! BusinessTableViewCell
        cell.business = self.businesses![indexPath.row]
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension BusinessesViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = nil
        searchBar.setShowsCancelButton(true, animated: true)

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
       setMapBtn()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}






