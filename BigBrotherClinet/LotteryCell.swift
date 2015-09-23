//
//  LotteryCell.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/9/23.
//  Copyright (c) 2015年 sunmin.me. All rights reserved.
//

import UIKit

class LotteryCell: UITableViewCell {

    var balls = Array<UILabel>()
    let redBallCount = 5
    let blueBallCount = 2
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for i in 0 ..< (redBallCount + blueBallCount) {
            let ballLabel = UILabel()
            if i  < redBallCount {
                ballLabel.backgroundColor = UIColor.redColor()
            }
            else {
                ballLabel.backgroundColor = UIColor.blueColor()
            }
            ballLabel.textColor = UIColor.whiteColor()
            ballLabel.textAlignment = .Center
            ballLabel.font = UIFont.systemFontOfSize(12)
            ballLabel.layer.cornerRadius = 15
            ballLabel.clipsToBounds = true
            self.contentView.addSubview(ballLabel)
            ballLabel.mas_makeConstraints{ make in
                make.left.equalTo()(30 + i * 40)
                make.width.equalTo()(30)
                make.centerY.equalTo()(self.contentView)
                make.height.equalTo()(30)
            }
            balls.append(ballLabel)
        }
        
        
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    func updateWithLottery(lottery : Array<String>) {
        assert(lottery.count == (redBallCount+blueBallCount), "彩票数字不对哦")
        for i in 0 ..< (redBallCount+blueBallCount) {
            self.balls[i].text = lottery[i]
        }
    }
    
    
    class func cellReuseIdentifier() -> String {
        return "cell"
    }
}
