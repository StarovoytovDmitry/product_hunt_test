//
//  DataManager.swift
//  product_hunt_test
//
//  Created by Дмитрий on 29.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit
import Alamofire

class DataManager {
    
    private var urlParams = [
        "access_token":"591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
        ]
    var categories = [""]
    
    func sendGetAllCategoriesRequest(tableView: UITableView)->Array<String> {
        // Add Headers
        let headers = [
            "Content-Type":"application/json",
            ]
        // Fetch Request
        Alamofire.request("https://api.producthunt.com/v1/categories", method: .get, parameters: urlParams, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                    let results = response.value as! NSDictionary
                    //print(results)
                    let categories_mas = results.value(forKey: "categories") as! NSArray
                    //print(categories_mas)
                    for i in categories_mas {
                        let tmp = (i as AnyObject).value(forKey: "slug") as! String
                        //print(tmp)
                        self.categories.append(tmp)
                        tableView.reloadData()
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        return categories
    }
    
    func sendPostsForCategoryRequest(category: String, success: @escaping ([Product]) -> (),  failyre: @escaping (NSError) -> ()) {
        // Add Headers
        let headers = [
            //"Authorization":"Bearer your_access_token",
            "Content-Type":"application/json",
            ]
        // JSON Body
        //let body: [String : Any] = [:]
        
        let url_req = "https://api.producthunt.com/v1/categories/"+category+"/posts"
        
        // Fetch Request
        Alamofire.request(url_req, method: .get, parameters: urlParams, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                    let result = response.value as! NSDictionary
                    let mas = result.value(forKey: "posts") as! NSArray
                    let x = mas as! [NSDictionary]
                    let products = Product.productsWithArray(dictionaries: x)
                    success(products)
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                    failyre(response.result.error as! NSError)
                }
        }
    }
}
