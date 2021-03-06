//
//  ViewController.swift
//  product_hunt_test
//
//  Created by Дмитрий on 29.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataManager = DataManager()
    var current_category : String? {
        didSet {
            getProducts()
        }
    }
    var products: [Product]?
    var categories : [String]?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.current_category = "tech"
        self.title = current_category
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        getCategories()
        //getProducts()
        
        //Set up pull to refresh loading
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.getProducts), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        //UserNotificationManager.shared.addNotification(text: "LOL")
    }
    
    func getCategories(){
        dataManager.sendGetAllCategoriesRequest(success: { (categories) in
            self.categories = categories
            self.pickerView.reloadAllComponents()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getProducts(){
        
        dataManager.sendPostsForCategoryRequest(category: current_category!, success: { (products) in
            self.products = products
            self.defaults.set(products.count, forKey: "countProducts")
            self.defaults.synchronize()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failyre: { (error) in
            print(error.localizedDescription)
        })
    }
    
    // MARK : TableView
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productVC = storyboard?.instantiateViewController(withIdentifier: "Product") as? ProductViewController
        productVC?.product = products?[indexPath.row]
        navigationController?.pushViewController(productVC!, animated: true)
        //productVC?.productView = products![indexPath.row].description as? String
    }
    
    // MARK: PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if categories == nil {
            return 0
        } else {
            return categories!.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        current_category = categories?[row]
        self.title = current_category
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
