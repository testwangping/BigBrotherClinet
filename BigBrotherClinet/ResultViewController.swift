//
//  ResultViewController.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/9/22.
//  Copyright (c) 2015年 sunmin.me. All rights reserved.
//

import UIKit
import SnapKit
import SMFoundation

class ResultViewController: UIViewController {

    private var tableView : UITableView?
    private var lotteries = Array<Array<Int>>()
    private var getting = false
    private let hostName = "lottery.sunmin.me"
//    private let hostName = "127.0.0.1:5000"
    
    private let type : LotteryType
    private let algorithm : LotteryAlgorithm
    // 如果是0则由本界面随机，否则是指定个数
    private var count = 0
    private var preferReds = Array<Int>()
    private var preferBlues = Array<Int>()
    
    
    init(type : LotteryType, algorithm : LotteryAlgorithm, count : Int, preferReds : [Int], preferBlues : [Int]) {
        self.type = type
        self.algorithm = algorithm
        self.count = count
        self.preferReds = preferReds
        self.preferBlues = preferBlues
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None;
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "手气不错"
        let l = UILabel()
        l.text = "再摇一摇即有大仙为您赐号"
        l.textAlignment = .Center
        l.textColor = UIColor.redColor()
        l.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(l)
        l.snp_makeConstraints{ make in
            make.top.equalTo(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.tableFooterView = UIView()
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp_makeConstraints{ make in
            make.top.equalTo(l.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.view)
        }
        
        self.getLottery()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        // 摇动中就不要再摇啦
        return !self.getting
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            self.getLottery()
        }
    }
    
    
    private func getLottery() {
        self.getting = true
        self.view.showWaitWithMessage("大仙作法中...")
        var thisCount = self.count
        if thisCount == 0 {
            thisCount = Int(arc4random()%4) + 1
        }
        let reds = preferReds.map{"\($0)"}.joinWithSeparator(",")
        let blues = preferBlues.map{"\($0)"}.joinWithSeparator(",")
        let urlString = "http://\(hostName)/lottery?type=\(type.rawValue)&algorithm=\(algorithm.rawValue)&count=\(thisCount)&preferreds=\(reds)&preferblues=\(blues)"
        let s = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            self.getting = false
            sm_dispatch_execute_in_main_queue_after(0.0, { () -> Void in
                self.view.hideWait()
                if (error == nil  && data != nil) {
                    let dic = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))) as? NSDictionary
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



extension ResultViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LotteryCell.standardHeight()
    }
    
}


extension ResultViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lotteries.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(LotteryCell.cellReuseIdentifier()) as? LotteryCell
        if cell == nil {
            cell = LotteryCell(style: .Default, reuseIdentifier: LotteryCell.cellReuseIdentifier(), type: self.type)
        }
        cell!.updateWithLottery(self.lotteries[indexPath.row])
        return cell!
        
    }
    
}
