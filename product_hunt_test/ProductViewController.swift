//
//  ProductViewController.swift
//  product_hunt_test
//
//  Created by Дмитрий on 01.02.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productUpvotes: UILabel!
    
    var product: Product?
    
    @IBAction func getProduct(_ sender: Any) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "Web") as? WebViewController
        webVC?.url = product?.urlPath as URL?
        navigationController?.pushViewController(webVC!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productName.text = product?.name as? String
        productDescription.text = product?.description as? String
        let up = Int((product?.upvoutes)!)
        productUpvotes.text = String(up)
        productView.downloadedFrom(url: product?.scrPath as! URL)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
