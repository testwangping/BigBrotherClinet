//
//  LotteryCell.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/9/23.
//  Copyright (c) 2015年 sunmin.me. All rights reserved.
//

import UIKit
import SMFoundation

class LotteryCell: UITableViewCell {

    var balls = Array<UILabel>()
    private let type : LotteryType
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, type : LotteryType) {
        self.type = type
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        
        let cellWidthOuter = Int(kScreenWidth() / 8)
        let cellWidthInner = Int(kScreenWidth() / 10)
        for i in 0 ..< (type.redBallCount() + type.blueBallCount()) {
            let ballLabel = UILabel()
            ballLabel.layer.borderWidth = 1
            ballLabel.textAlignment = .Center
            ballLabel.font = UIFont.systemFontOfSize(14)
            ballLabel.layer.cornerRadius = CGFloat(cellWidthInner)/2
            ballLabel.clipsToBounds = true
            if i >= type.redBallCount() {
                ballLabel.layer.borderColor = UIColor.blueColor().CGColor
                ballLabel.textColor = UIColor.blueColor()
            }
            else {
                ballLabel.layer.borderColor = UIColor.redColor().CGColor
                ballLabel.textColor = UIColor.redColor()
            }
            
            self.contentView.addSubview(ballLabel)
            ballLabel.snp_makeConstraints{ make in
                make.left.equalTo(20 + i * cellWidthOuter + (i >= type.redBallCount() ? 20 : 0))
                make.width.equalTo(cellWidthInner)
                make.centerY.equalTo(self.contentView)
                make.height.equalTo(cellWidthInner)
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
