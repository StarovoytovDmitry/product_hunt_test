//
//  tableViewCell.swift
//  product_hunt_test
//
//  Created by Дмитрий on 29.01.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productUpvotes: UILabel!
}
