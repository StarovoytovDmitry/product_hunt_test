//
//  Product.swift
//  product_hunt_test
//
//  Created by Дмитрий on 31.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

class Product {
    
    var name: NSString?
    var description: NSString?
    var upvoutes: Int = 0
    var imgPath: NSURL?
    var urlPath: NSURL?
    var scrPath: NSURL?
    
    init(dictionary: NSDictionary) {
        self.name = dictionary.value(forKey: "name") as? NSString
        self.description = dictionary.value(forKey: "tagline") as? NSString
        self.upvoutes = (dictionary.value(forKey: "votes_count") as? Int) ?? 0
        
        let str_url = (dictionary.value(forKey: "thumbnail") as! NSDictionary).value(forKey: "image_url") as! String
        self.imgPath = NSURL(string: str_url)
        
        let url = dictionary.value(forKey: "discussion_url") as! String
        self.urlPath = NSURL(string: url)
        
        let scr_url = (dictionary.value(forKey: "screenshot_url") as! NSDictionary).value(forKey: "850px") as! String
        self.scrPath = NSURL(string: scr_url)
    }
    
    class func productsWithArray(dictionaries: [NSDictionary]) -> [Product] {
        var products = [Product]()
        
        for dictionary in dictionaries {
            let product = Product(dictionary: dictionary)
            products.append(product)
        }
        return products
    }
    
}
