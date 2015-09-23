//
//  ViewController.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/9/22.
//  Copyright (c) 2015年 sunmin.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tableView : UITableView?
    private var lotteries = Array<Array<Int>>()
    private var getting = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let l = UILabel()
        l.text = "摇一摇即有大仙为您赐号"
        l.textAlignment = .Center
        l.textColor = UIColor.blueColor()
        l.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(l)
        l.mas_makeConstraints{ make in
            make.top.equalTo()(40)
            make.left.equalTo()(0)
            make.right.equalTo()(0)
        }
        
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.registerClass(LotteryCell.self, forCellReuseIdentifier: LotteryCell.cellReuseIdentifier())
        tableView?.tableFooterView = UIView()
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.mas_makeConstraints{ make in
            make.top.equalTo()(l.mas_bottom).with().offset()(20)
            make.left.equalTo()(0)
            make.right.equalTo()(0)
            make.bottom.equalTo()(self.view)
        }
        
    }
    
    override func canBecomeFirstResponder() -> Bool {
        // 摇动中就不要再要啦
        return !self.getting
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            self.getLottery()
        }
    }
    
    
    private func getLottery() {
        self.getting = true
        self.view.showWaitWithMessage("大仙作法中...")
        let count = String(format: "%d", arc4random()%4+1)
        let s = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://lottery.sunmin.me/lottery?type=superlotto&algorithm=random&count=" + count)!, completionHandler: { (data, response, error) -> Void in
            self.getting = false
            sm_dispatch_execute_in_main_queue_after(0.0, { () -> Void in
                self.view.hideWait()
                if error == nil {
                    let dic = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSDictionary
                    if dic != nil {
                        self.lotteries = dic!.objectForKey("lottery_list") as! Array<Array<Int>>
                        self.tableView!.reloadData()
                    }
                }
            })
        })
        s.resume()
    }
    
}



extension ViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}


extension ViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lotteries.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(LotteryCell.cellReuseIdentifier()) as! LotteryCell
        cell.updateWithLottery(self.lotteries[indexPath.row])
        return cell
        
    }
    
}
