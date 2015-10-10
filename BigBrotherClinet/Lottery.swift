//
//  Lottery.swift
//  BigBrotherClinet
//
//  Created by GongpingjiaNanjing on 15/10/9.
//  Copyright © 2015年 sunmin.me. All rights reserved.
//

import Foundation

enum LotteryType : String {
    case SuperLotto = "superlotter"
    case WelfareLotto = "welfarelotto"
    
    func blueBallCount() -> Int {
        switch self {
        case SuperLotto:
            return 5
            
        case .WelfareLotto:
            return 6
        }
    }
    
    
    func redBallCount() -> Int {
        switch self {
        case SuperLotto:
            return 2
            
        case .WelfareLotto:
            return 1
        }
    }
    
    
    func blueBallMinValue() -> Int {
        return 1
    }
    
    
    func blueBallMaxValue() -> Int {
        switch self {
        case SuperLotto:
            return 35
            
        case .WelfareLotto:
            return 33
        }
    }
    
    
    func redBallMinValue() -> Int {
        return 1
    }
    
    
    func redBallMaxValue() -> Int {
        switch self {
        case SuperLotto:
            return 12
            
        case .WelfareLotto:
            return 16
        }
    }
    
}


enum LotteryAlgorithm : String {
    case Random = "random"
    case Prefer = "prefer"
    
}