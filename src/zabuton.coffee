# Description:
#   Give, Take and List Zabuton (座布団), a la 笑点
#   https://en.wikipedia.org/wiki/Sh%C5%8Dten
#
#  More fun if you use "--alias yamadakun" to run hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Todo:
#   Special prize for 10 zabuton
#   Make text more accurate with respect to the show
#     Special message for many zabuton given at once
#     Special message for many zabuton removed at once
#   Handle full-width numbers (全角数字)
#   Remove extra zabuton for each "ー" after "寒いー"
#
# Special Thanks:
#   brettlangdon, who build points.coffee, on which this module is based
#
# Commands:
#   hubot give <number> zabuton to <username> - award <number> zabuton to <username>
#   hubot give <username> <number> zabuton - award <number> zabuton to <username>
#   hubot take <number> zabuton from <username> - take away <number> zabuton from <username>
#   hubot how many zabuton does <username> have? - list how many zabuton <username> has
#   hubot take all zabuton from <username> - removes all zabuton from <username>
#
#   # 座布団 =~ (座布団|ざぶとん|ザブトン)
#   hubot <username>に座布団<number>枚 - award <number> zabuton to <username>
#   hubot <username>(から|の)座布団<number>枚 - take away <number> zabuton from <username>
#   hubot <username>(、|\s)?(寒い|さむい|サムイ|さみー) - take away 1 zabuton from <username>
#   hubot <username>は?座布団何枚 - list how many zabuton <username> has
#   hubot <username>(から|の)座布団全部 - removes all zabuton from <username>
#
# Author:
#   Nathaniel Heinrichs <nheinric at cpan.org>
#

points = {}

award_points = (msg, lang, username, pts) ->
    points[username] ?= 0
    points[username] += parseInt(pts)
    if lang is 'ja'
      msg.send username + 'に座布団' + pts + '枚やった'
    else
      msg.send pts + ' Awarded To ' + username

decrement_points = (msg, lang, username, pts) ->
    points[username] ?= 0
    pts = points[username] if pts is 'all'

    if points[username] is 0
      if lang is 'ja'
        msg.send username + 'じゃ座布団1枚も無い!'
      else
        msg.send username + ' Does Not Have Any Zabuton To Take Away'
    else
      points[username] -= parseInt(pts)
      if lang is 'ja'
        if points[username] is 0
          msg.send username + 'よ、何しとってん?!'
        else
          msg.send username + 'から座布団' + pts + '枚取っといた'
      else
        if points[username] is 0
          msg.send username + ' WHAT DID YOU DO?!'
        else
          msg.send pts + ' Zabuton Taken Away From ' + username

save = (robot) ->
    robot.brain.data.zabuton = points

module.exports = (robot) ->
    robot.brain.on 'loaded', ->
        points = robot.brain.data.zabuton or {}

    robot.respond /give (\d+) zabuton to (.*?)\s?$/i, (msg) ->
        award_points(msg, 'en', msg.match[2], msg.match[1])
        save(robot)

    robot.respond /give (.*?) (\d+) zabuton/i, (msg) ->
        award_points(msg, 'en', msg.match[1], msg.match[2])
        save(robot)

    robot.respond /take all zabuton from (.*?)\s?$/i, (msg) ->
        username = msg.match[1]
        decrement_points( msg, 'en', username, 'all' )
        save(robot)

    robot.respond /take (\d+) zabuton from (.*?)\s?$/i, (msg) ->
        pts = msg.match[1]
        username = msg.match[2]
        decrement_points( msg, 'en', username, pts )
        save(robot)

    robot.respond /how many zabuton does (.*?) have\??/i, (msg) ->
        username = msg.match[1]
        points[username] ?= 0

        msg.send username + ' Has ' + points[username] + ' Zabuton'

    # Only capturing '枚' to make tests for increment/decrement similar
    robot.respond /(.+)に(?:座布団|ざぶとん|ザブトン)(\d+枚)/, (msg) ->
        pts = msg.match[2].match(/^(\d+)枚/)
        award_points(msg, 'ja', msg.match[1], pts[1])
        save(robot)

    robot.respond /(.+)(?:から|の)(?:座布団|ざぶとん|ザブトン)(.*)/, (msg) ->
        username = msg.match[1]
        pts      = msg.match[2]
        if match = pts.match(/^(\d+)枚/)
            decrement_points( msg, 'ja', username, match[1] )
        else if match = pts.match(/^全部/)
            decrement_points( msg, 'ja', username, 'all' )
        else
            return false
        save(robot)

    robot.respond /(.+?)(?:(?:[、　 ]*)?(?:寒い|さむい|サムイ|さみー))/, (msg) ->
        username = msg.match[1]
        decrement_points( msg, 'ja', username, 1 )
        save(robot)

    # Last 'は' in a name like "なはは" will be swallowed.
    robot.respond /(.+?)は?(?:座布団|ざぶとん|ザブトン)何枚/, (msg) ->
        username = msg.match[1]
        points[username] ?= 0

        msg.send username + 'じゃ座布団' + points[username] + '枚持っとる'
