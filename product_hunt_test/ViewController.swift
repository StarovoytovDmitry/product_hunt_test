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
    let current_category : String = "tech"
    var products: [Product]?
    
    @IBOutlet weak var tableView: UITableView!
    var x : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = current_category
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        x = dataManager.sendGetAllCategoriesRequest(tableView: tableView).count
        dataManager.sendPostsForCategoryRequest(category: current_category, success: { (products) in
            self.products = products
            self.tableView.reloadData()
            //print(products)
        }, failyre: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products == nil {
            return 0
        } else {
            return products!.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCustomTableViewCell
        //print(dataManager.categories.count)
        cell.product = products![indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
