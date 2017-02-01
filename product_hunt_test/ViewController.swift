//
//  ViewController.swift
//  product_hunt_test
//
//  Created by Дмитрий on 29.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataManager = DataManager()
    let current_category : String = "tech"
    var products: [Product]?
    var categories : [String]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = current_category
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        dataManager.sendGetAllCategoriesRequest(success: { (categories) in
            self.categories = categories
            self.pickerView.reloadAllComponents()
        }) { (error) in
            print(error.localizedDescription)
        }
        
        dataManager.sendPostsForCategoryRequest(category: current_category, success: { (products) in
            self.products = products
            self.tableView.reloadData()
            //print(products)
        }, failyre: { (error) in
            print(error.localizedDescription)
        })
    }
    // MARK : Table View
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
    
    // MARK: Picker View
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
