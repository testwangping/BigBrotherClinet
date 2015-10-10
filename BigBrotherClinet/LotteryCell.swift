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
    private let type : LotteryType
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, type : LotteryType) {
        self.type = type
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        
        for i in 0 ..< (type.redBallCount() + type.blueBallCount()) {
            let ballLabel = UILabel()
            if i >= type.blueBallCount() {
                ballLabel.backgroundColor = UIColor.redColor()
            }
            else {
                ballLabel.backgroundColor = UIColor.blueColor()
            }
            ballLabel.textColor = UIColor.whiteColor()
            ballLabel.textAlignment = .Center
            ballLabel.font = UIFont.systemFontOfSize(12)
            ballLabel.layer.cornerRadius = 18
            ballLabel.clipsToBounds = true
            self.contentView.addSubview(ballLabel)
            ballLabel.snp_makeConstraints{ make in
                make.left.equalTo(20 + i * 40)
                make.width.equalTo(36)
                make.centerY.equalTo(self.contentView)
                make.height.equalTo(36)
            }
            balls.append(ballLabel)
        }

    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func updateWithLottery(lottery : Array<Int>) {
        assert(lottery.count == (type.redBallCount()+type.blueBallCount()), "彩票数字不对哦")
        for i in 0 ..< (type.redBallCount()+type.blueBallCount()) {
            self.balls[i].text = String(format: "%d", lottery[i])
        }
    }
    
    
    class func cellReuseIdentifier() -> String {
        return "cell"
    }
    
    
    class func standardHeight() -> CGFloat {
        return 60.0
    }
}
