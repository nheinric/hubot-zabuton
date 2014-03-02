chai   = require 'chai'
sinon  = require 'sinon'
events = require 'events'
chai.use require 'sinon-chai'

expect = chai.expect
brain  = new events.EventEmitter()

strToMatch = ''
matchFunc  = (val) ->
    expect(val).to.be.a( 'regexp' )
    match = strToMatch.match( val )
    return match != null
regexpMatcher = sinon.match( matchFunc, 'Matches' + strToMatch )

# todo Test point increment/decrement
# todo Test responses
describe 'hubot-zabuton', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      brain:   brain

    require('../src/zabuton')(@robot)
    strToMatch = ''

  it 'responds to /give (\d+) zabuton to (.*?)\s?$/i', ->
    strToMatch = 'give 1 zabuton to bob'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /give (.*?) (\d+) zabuton/i', ->
    strToMatch = 'give bob 1 zabuton'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /take all zabuton from (.*?)\s?$/i', ->
    strToMatch = 'take all zabuton from bob'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /take (\d+) zabuton from (.*?)\s?$/i', ->
    strToMatch = 'take 1 zabuton from bob'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /how many zabuton does (.*?) have\??/i', ->
    strToMatch = 'how many zabuton does bob have'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)に(座布団|ざぶとん|ザブトン)(\d+)枚/', ->
    strToMatch = 'bobに座布団1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobにざぶとん1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobにザブトン1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)(から|の)(座布団|ざぶとん|ザブトン)全部/', ->
    strToMatch = 'bobから座布団全部'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobからざぶとん全部'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobからザブトン全部'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobの座布団全部'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobのざぶとん全部'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobのザブトン全部'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)(から|の)(座布団|ざぶとん|ザブトン)(\d+)枚/', ->
    strToMatch = 'bobから座布団1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobからざぶとん1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobからザブトン1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobの座布団1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobのざぶとん1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobのザブトン1枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)(、|\s)?(寒い|さむい|サムイ|さみー)/', ->
    strToMatch = 'bob寒い'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobさむい'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobサムイ'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobさみー'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob、寒い'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob、さむい'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob、サムイ'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob、さみー'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob 寒い'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob さむい'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob サムイ'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bob さみー'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)は?(座布団|ざぶとん|ザブトン)何枚/', ->
    strToMatch = 'bob座布団何枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobざぶとん何枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobザブトン何枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobは座布団何枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobはざぶとん何枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
    strToMatch = 'bobはザブトン何枚'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
