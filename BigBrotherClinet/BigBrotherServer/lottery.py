# coding=UTF-8
from flask import Flask
import random
import json
import SuperLotto

app = Flask(__name__)

def lottery(type='SuperLotto', algorithm='random', count=1)
    #目前只支持随机嘻嘻
    if type == 'SuperLotto':
        if algorithm == 'random':
            return SuperLotto.random(count)


@app.route('/')
def hello_world():
    return 'Hello Lottery'


@app.route('/lottery')
def lottery():
    # 参数优先看 类型(大乐透|福彩)，其次看玩法(随机|真算)，最后看注数，默认值是大乐透，随机，一注
    type = request.args.get('type')
    algorithm = request.args.get('algorithm')
    count = request.args.get('count')
    s = map(str, ls)
    return json.dumps({'status' : 'success', 'lottery_list' : [s]})


@app.route('')



if __name__ == '__main__':
    app.run()
