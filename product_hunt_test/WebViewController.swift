//
//  WebViewController.swift
//  product_hunt_test
//
//  Created by Дмитрий on 02.02.17.
//  Copyright © 2017 js. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestObj = NSURLRequest(url: url!);
        webView.loadRequest(requestObj as URLRequest);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
