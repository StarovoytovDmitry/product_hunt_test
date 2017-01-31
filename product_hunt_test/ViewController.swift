//
//  ViewController.swift
//  product_hunt_test
//
//  Created by Дмитрий on 29.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    var x : Int = 0
    /*
    var products: [DataManager]? {
        didSet {
            x = dataManager.sendGetAllCategoriesRequest().count
            //lastTweetId = tweets![tweets!.endIndex - 1].tweetID as Int
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        x = dataManager.sendGetAllCategoriesRequest(tableView: tableView).count
        dataManager.sendPostsForCategoryRequest(tableView: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCustomTableViewCell
        //print(dataManager.categories.count)
        cell.productName.text = "1"
        cell.productDescription.text = "1"
        cell.productUpvotes.text = "1"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
