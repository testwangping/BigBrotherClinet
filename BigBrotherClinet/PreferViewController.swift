//
//  PreferViewController.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/10/8.
//  Copyright © 2015年 sunmin.me. All rights reserved.
//

import UIKit
import SMFoundation

class PreferViewController: UIViewController {
    
    private let blueBallTagIndex = 1000
    private let redBallTagIndex = 2000
    private let tagForBallLabel = 999

    private let type : LotteryType
    private var preferBlues = [Int]()
    private var preferReds = [Int]()
    // 我本来也想不同尺寸显示不同的个数，但是如果出现未知尺寸我还是得改，那么还不如写死一个值
    private let oneLineBallCount = 7

    
    init(type : LotteryType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 这里隐藏条件是整体左右间隔各是20
    private func geneBallsView(isBlue isBlue : Bool) -> UIView {
        
        let outterMargin = 20
        let innerMargin = 8
        let ballOuterWidth = (Int(kScreenWidth()) - (outterMargin * 2 + innerMargin * 2)) / oneLineBallCount
        let ballInnerWidth = 30
        let maxValue = isBlue ? self.type.blueBallMaxValue() : self.type.redBallMaxValue()

        let ballsView = UIView()
        ballsView.layer.cornerRadius = 5.0
        ballsView.layer.borderColor = UIColor.grayColor().CGColor
        ballsView.layer.borderWidth = 0.5
        self.view.addSubview(ballsView)
        ballsView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(outterMargin)
            make.right.equalTo(-outterMargin)
            let h = innerMargin * 2 + ballOuterWidth * (maxValue / oneLineBallCount + Int(maxValue % oneLineBallCount != 0))
            make.height.equalTo(h)
        }
        
        let title = String(format: "请选择%@球，不超过%d个", (isBlue ? "蓝" : "红"), (isBlue ? self.type.blueBallCount() : self.type.redBallCount()))
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.grayColor()
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        self.view.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(ballsView).offset(20)
            make.top.equalTo(ballsView).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(150)
        }
        
        
        let borderColor = isBlue ? UIColor.blueColor().CGColor : UIColor.redColor().CGColor
        let beginTagIndex = isBlue ? blueBallTagIndex : redBallTagIndex
        
        for var ballIndex in 1 ... maxValue {
            let ballView = UIView()
            ballView.tag = beginTagIndex + ballIndex
            ballView.userInteractionEnabled = true
            ballView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "ballTapped:"))
            ballIndex--
            ballsView.addSubview(ballView)
            ballView.snp_makeConstraints{ (make) -> Void in
                make.top.equalTo(innerMargin + ballOuterWidth * (ballIndex / oneLineBallCount))
                make.left.equalTo(innerMargin + ballOuterWidth * (ballIndex % oneLineBallCount))
                make.width.equalTo(ballOuterWidth)
                make.height.equalTo(ballOuterWidth)
            }
            
            let ballLabel = UILabel()
            ballLabel.tag = tagForBallLabel
            ballLabel.text = "\(++ballIndex)"
            ballLabel.textAlignment = .Center
            ballLabel.font = UIFont.systemFontOfSize(12)
            ballLabel.backgroundColor = UIColor.whiteColor()
            ballLabel.layer.borderWidth = 1
            ballLabel.layer.borderColor = borderColor
            ballLabel.layer.cornerRadius = CGFloat(ballInnerWidth/2)
            ballLabel.clipsToBounds = true
            ballView.addSubview(ballLabel)
            ballLabel.snp_makeConstraints{ (make) -> Void in
                make.centerX.equalTo(ballView)
                make.centerY.equalTo(ballView)
                make.width.equalTo(ballInnerWidth)
                make.height.equalTo(ballInnerWidth)
            }
            
        }
        
        
        return ballsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None;
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let blueBallsView = self.geneBallsView(isBlue:true)
        blueBallsView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(30)
        }
        
        let redBallsView = self.geneBallsView(isBlue: false)
        redBallsView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(blueBallsView.snp_bottom).offset(30)
        }

        let commitButton = UIButton()
        commitButton.layer.cornerRadius = 5.0
        commitButton.layer.borderColor = UIColor.grayColor().CGColor
        commitButton.layer.borderWidth = 0.5
        commitButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        commitButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        commitButton.setTitle("跪求大仙做法", forState: .Normal)
        commitButton.addTarget(self, action: "commitTapped:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(commitButton)
        commitButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(redBallsView.snp_bottom).offset(20)
            make.height.equalTo(44)
        }
        
    }
    
    
    func ballTapped(gr : UIGestureRecognizer) {
        gr.view!.userInteractionEnabled = false
        sm_dispatch_execute_in_main_queue_after(1.0) { () -> Void in
            gr.view!.userInteractionEnabled = true
        }
        let tag = gr.view!.tag
        if tag > redBallTagIndex {
            let index = tag - redBallTagIndex
            if let ss = preferReds.indexOf(index) {
                preferReds.removeAtIndex(ss)
                gr.view?.viewWithTag(tagForBallLabel)?.backgroundColor = UIColor.whiteColor()
            }
            else {
                // 目前这个其实不是真复式哦,下同
                if preferReds.count < self.type.redBallCount() {
                    preferReds.append(index)
                    gr.view?.viewWithTag(tagForBallLabel)?.backgroundColor = UIColor.redColor()
                }
            }
        }
        else {
            let index = tag - blueBallTagIndex
            if let ss = preferBlues.indexOf(index) {
                preferBlues.removeAtIndex(ss)
                gr.view?.viewWithTag(tagForBallLabel)?.backgroundColor = UIColor.whiteColor()
            }
            
            else {
                if preferBlues.count < self.type.blueBallCount() {
                    preferBlues.append(index)
                    gr.view?.viewWithTag(tagForBallLabel)?.backgroundColor = UIColor.blueColor()
                }
            }
        }
    }
    
    
    func commitTapped(button : UIButton) {
        
        button.userInteractionEnabled = false
        sm_dispatch_execute_in_main_queue_after(1.0) { () -> Void in
            button.userInteractionEnabled = true
        }
        
        if (preferBlues.count >= self.type.blueBallCount()) && (preferReds.count >= self.type.redBallCount()) {
            self.view.alert("你他妈全选好了还赐号个屁")
            return
        }
        
        let c = ResultViewController(type: self.type, algorithm: .Prefer, count: 0, preferBlues: preferBlues, preferReds: preferReds)
        self.navigationController?.pushViewController(c, animated: true)
    }
    
    
}
