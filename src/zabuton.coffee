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
#   hubot take all zabuton from <username> - removes all zabuton from <username>
#   hubot how many zabuton does <username> have? - list how many zabuton <username> has
#
#   hubot <username> に座布団<number>枚 - award <number> zabuton to <username>
#   hubot <username> から座布団<number>枚取って - take away <number> zabuton from <username>
#   hubot <username> の座布団全部取って - removes all zabuton from <username>
#   hubot <username> (、|\s)?(寒い|さむい|サムイ|さみー) - take away 1 zabuton from <username>
#   hubot <username> は座布団何枚? - list how many zabuton <username> has
#
# Author:
#   Nathaniel Heinrichs <nheinric at cpan.org>
#

points = {}

award_points = (msg, lang, username, zabuton, pts) ->
    points[username] ?= {}
    points[username][zabuton] ?= 0
    points[username][zabuton] += parseInt(pts)
    if lang is 'ja'
      msg.send username + ' に ' + zabuton + ' ' + pts + ' 枚やった'
    else
      msg.send pts + ' ' + zabuton + ' Awarded To ' + username

decrement_points = (msg, lang, username, zabuton, pts) ->
    points[username] ?= {}
    points[username][zabuton] ?= 0
    pts = points[username][zabuton] if pts is 'all'

    if points[username][zabuton] is 0
      if lang is 'ja'
        msg.send username + ' は ' + zabuton + ' 1 枚も無い!'
      else
        msg.send username + ' Does Not Have Any ' + zabuton + ' To Take Away'
    else
      points[username][zabuton] -= parseInt(pts)
      if lang is 'ja'
        if points[username][zabuton] is 0
          msg.send username + ' よ、何しとってん?!'
        else
          msg.send username + ' から ' + zabuton + ' ' + pts + ' 枚取っといた'
      else
        if points[username][zabuton] is 0
          msg.send username + ' WHAT DID YOU DO?!'
        else
          msg.send pts + ' ' + zabuton + ' Taken Away From ' + username

save = (robot) ->
    robot.brain.data.zabuton = points

module.exports = (robot) ->
    robot.brain.on 'loaded', ->
        points = robot.brain.data.zabuton or {}

    robot.respond /give (\d+) (.*?) to (.*?)\s?$/i, (msg) ->
        award_points(msg, 'en', msg.match[3], msg.match[2], msg.match[1])
        save(robot)

    robot.respond /give (.*?) (\d+) (.*?)\s?$/i, (msg) ->
        award_points(msg, 'en', msg.match[1], msg.match[3], msg.match[2])
        save(robot)

    robot.respond /take all (.*?) from (.*?)\s?$/i, (msg) ->
        decrement_points(msg, 'en', msg.match[2], msg.match[1], 'all')
        save(robot)

    robot.respond /take (\d+) (.*?) from (.*?)\s?$/i, (msg) ->
        decrement_points(msg, 'en', msg.match[3], msg.match[2], msg.match[1])
        save(robot)

    robot.respond /how many (.*?) does (.*?) have\??/i, (msg) ->
        username = msg.match[2]
        zabuton = msg.match[1]
        points[username] ?= {}
        points[username][zabuton] ?= 0

        msg.send username + ' Has ' + points[username][zabuton] + ' ' + zabuton

    # Only capturing '枚' to make tests for increment/decrement similar
    robot.respond /(.+)に(.+)(\d+枚)/, (msg) ->
        username = msg.match[1].replace /^\s+|\s+$/g, ""
        zabuton = msg.match[2].replace /^\s+|\s+$/g, ""
        pts = msg.match[3].match(/^(\d+)枚/)
        award_points(msg, 'ja', username, zabuton, pts[1])
        save(robot)

    robot.respond /(.+)から(.+)(\d+枚取って)/, (msg) ->
        username = msg.match[1].replace /^\s+|\s+$/g, ""
        zabuton = msg.match[2].replace /^\s+|\s+$/g, ""
        pts = msg.match[3].match(/^(\d+)枚/)
        decrement_points( msg, 'ja', username, zabuton, pts[1] )
        save(robot)

    robot.respond /(.+)の(.+)全部取って/, (msg) ->
        username = msg.match[1].replace /^\s+|\s+$/g, ""
        zabuton = msg.match[2].replace /^\s+|\s+$/g, ""
        decrement_points( msg, 'ja', username, zabuton, 'all' )
        save(robot)

    robot.respond /(.+?)(?:(?:[、　 ]*)?(?:寒い|さむい|サムイ|さみー))/, (msg) ->
        username = msg.match[1].replace /^\s+|\s+$/g, ""
        decrement_points(msg, 'ja', username, '座布団', 1)
        save(robot)

    # Last 'は' in a name like "なはは" will be swallowed.
    robot.respond /(.+?)は(.+?)何枚?/, (msg) ->
        username = msg.match[1].replace /^\s+|\s+$/g, ""
        zabuton = msg.match[2].replace /^\s+|\s+$/g, ""
        points[username] ?= {}
        points[username][zabuton] ?= 0

        msg.send username + ' は ' + zabuton + ' ' + points[username][zabuton] + '枚持っとる'
