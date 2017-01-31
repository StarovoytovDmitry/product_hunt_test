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
        
        // Add URL parameters
        /*let urlParams = [
            "access_token":"591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
            ]
        */
        
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
    
    func sendPostsForCategoryRequest(tableView: UITableView)->Int {
        // Add Headers
        let headers = [
            //"Authorization":"Bearer your_access_token",
            "Content-Type":"application/json",
            ]
        
        // JSON Body
        //let body: [String : Any] = [:]
        
        // Fetch Request
        Alamofire.request("https://api.producthunt.com/v1/categories/tech/posts", method: .get, parameters: urlParams, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                    let result = response.value as! NSDictionary
                    let mas = result.value(forKey: "posts") as! NSArray
                    
                    //print(mas[0])
                    //let tmp = (mas[0] as AnyObject).value(forKey: "name") as! NSString
                    //(mas[i] as AnyObject).value(forKey: "tagline") as! NSString
                    //(mas[i] as AnyObject).value(forKey: "voutes_count") as! NSInteger
                    let tmp = ((mas[0] as AnyObject).value(forKey: "thumbnail") as! NSDictionary).value(forKey: "image_url") as! String
                    let x = NSURL(string: tmp)
                    print(tmp)
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        return 3
    }
}
