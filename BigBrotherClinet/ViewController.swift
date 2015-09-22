//
//  ViewController.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/9/22.
//  Copyright (c) 2015年 sunmin.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let s = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://lottery.sunmin.me/lottery")!, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let ss = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(ss)
            }
        })
        s.resume()
        
    }

    
    
}

