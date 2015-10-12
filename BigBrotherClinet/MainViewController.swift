//
//  MainViewController.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/10/8.
//  Copyright © 2015年 sunmin.me. All rights reserved.
//

import UIKit
import SMFoundation

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slButton = UIButton()
        slButton.layer.cornerRadius = 5.0
        slButton.layer.borderColor = UIColor.grayColor().CGColor
        slButton.layer.borderWidth = 0.5
        slButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        slButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        slButton.setTitle("大乐透精细选号", forState: .Normal)
        slButton.addTarget(self, action: "supperLottoTapped:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(slButton)
        
        let welButton = UIButton()
        welButton.layer.cornerRadius = 5.0
        welButton.layer.borderColor = UIColor.redColor().CGColor
        welButton.layer.borderWidth = 0.5
        welButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        welButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        welButton.setTitle("福彩精细选号", forState: .Normal)
        welButton.addTarget(self, action: "welfareLottoTapped:", forControlEvents: .TouchUpInside)

        self.view.addSubview(welButton)
        
        let luckyButton = UIButton()
        luckyButton.layer.cornerRadius = 5.0
        luckyButton.layer.borderColor = UIColor.blueColor().CGColor
        luckyButton.layer.borderWidth = 0.5
        luckyButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        luckyButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        luckyButton.titleLabel?.numberOfLines = 2
        luckyButton.titleLabel?.textAlignment = .Center
        
        let s = NSMutableAttributedString(string: "手气不错\n", attributes: [NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(30)])
        s.appendAttributedString(NSAttributedString(string: "摇一摇即可直接获得赐号", attributes: [NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(15)]))
        luckyButton.setAttributedTitle(s, forState: .Normal)
        luckyButton.addTarget(self, action: "luckyTapped:", forControlEvents: .TouchUpInside)
        self.view.addSubview(luckyButton)
        
        slButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(60)
            make.height.equalTo(welButton)
        }
        
        welButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(slButton.snp_bottom).offset(80)
            make.height.equalTo(luckyButton)
        }
        
        luckyButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(welButton.snp_bottom).offset(80)
            make.height.equalTo(slButton)
            make.bottom.equalTo(self.view).offset(-60)
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func supperLottoTapped(button : UIButton) {
        let c = PreferViewController(type: .SuperLotto)
        c.title = button.titleForState(.Normal)
        self.navigationController?.pushViewController(c, animated: true)
    }
    
    
    func welfareLottoTapped(button : UIButton) {
        let c = PreferViewController(type: .WelfareLottery)
        c.title = button.titleForState(.Normal)
        self.navigationController?.pushViewController(c, animated: true)
    }
    
    
    func luckyTapped(button : UIButton) {
        let c = ResultViewController(type: self.todayIsSuperLottoDay() ? .SuperLotto : .WelfareLottery, algorithm: .Random, count: 0, preferReds: [], preferBlues: [])
        self.navigationController?.pushViewController(c, animated: true)
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            
        }
    }
    
    // 根据时间来给你选择不同的种类1，3，56是大乐透，2，4，7是福彩
    private func todayIsSuperLottoDay() -> Bool {
        let now = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let unitFlags: NSCalendarUnit = [.Weekday]
        let comps = calendar?.components(unitFlags, fromDate: now)
        let week = comps?.weekday
        // 不过这里1是周日，7是周六哦
        return (week == 6) || (week == 7) || (week == 2) || (week == 4)
    }

}
