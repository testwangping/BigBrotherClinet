# coding=UTF-8
import BaseAlgorithm

# const
SuperLottoRedBallCount = 5
SuperLottoBlueBallCount = 2
SuperLottoTotalBallCount = SuperLottoRedBallCount + SuperLottoBlueBallCount
SuperLottoRedBallMinValue = 1
SuperLottoRedBallMaxValue = 35
SuperLottoBlueBallminValue = 1
SuperLottoBlueBallMaxValue = 12

def random(count = 1)
    ls = []
    for i in range(0, count):
        redBalls = BaseAlgorithm.geneRandomDistinctList(SuperLottoRedBallCount, SuperLottoRedBallMinValue, SuperLottoRedBallMaxValue)
        blueBalls = BaseAlgorithm.geneRandomDistinctList(SuperLottoBlueBallCount, SuperLottoBlueBallMinValue, SuperLottoBlueBallMaxValue)
        ls.append(redBalls + blueBalls)
    return ls