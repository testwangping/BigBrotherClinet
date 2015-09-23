# coding=UTF-8
__author__ = 'study_sun'

import random

def geneRandomDistinctList(totalCount, minValue, maxValue):
    sourceList = []
    while (len(sourceList) < totalCount) :
        while (1):
            r = random.choice(range(minValue,maxValue))
            if not (r in sourceList):
                sourceList.append(r)
                break
    sourceList.sort()
    return sourceList

