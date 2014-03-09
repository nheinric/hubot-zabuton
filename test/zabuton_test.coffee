chai   = require 'chai'
sinon  = require 'sinon'
events = require 'events'
chai.use require 'sinon-chai'

expect = chai.expect
brain  = new events.EventEmitter()

strToMatch      = ''
expectedMatches = []
matchFunc = ( val ) ->
  expect(val).to.be.a( 'regexp' )
  matches = strToMatch.match( val )
  return false if matches == null
  matches.shift() # Discard full string match
  for match in matches
    expect(match).to.equal(expectedMatches.shift())
  return true
regexpMatcher = sinon.match( matchFunc, 'Matches' + strToMatch )

# todo Test point increment/decrement
# todo Test responses
describe 'hubot-zabuton', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      brain:   brain
    strToMatch = ''
    passed     = false
    require('../src/zabuton')(@robot)

  it 'responds to /give (\d+) zabuton to (.*?)\s?$/i', ->
    strToMatch      = 'give 1 zabuton to bob'
    expectedMatches = [ '1', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /give (.*?) (\d+) zabuton/i', ->
    strToMatch      = 'give bob 1 zabuton'
    expectedMatches = [ 'bob', '1' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /take all zabuton from (.*?)\s?$/i', ->
    strToMatch      = 'take all zabuton from bob'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /take (\d+) zabuton from (.*?)\s?$/i', ->
    strToMatch      = 'take 1 zabuton from bob'
    expectedMatches = [ '1', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /how many zabuton does (.*?) have\??/i', ->
    strToMatch      = 'how many zabuton does bob have'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)に座布団(\d+)枚/', ->
    strToMatch      = 'bobに座布団1枚'
    expectedMatches = [ 'bob', '1' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)にざぶとん(\d+)枚/', ->
    strToMatch      = 'bobにざぶとん1枚'
    expectedMatches = [ 'bob', '1' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)にザブトン(\d+)枚/', ->
    strToMatch      = 'bobにザブトン1枚'
    expectedMatches = [ 'bob', '1' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)から座布団全部/', ->
    strToMatch      = 'bobから座布団全部'
    expectedMatches = [ 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からざぶとん全部/', ->
    strToMatch      = 'bobからざぶとん全部'
    expectedMatches = [ 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からザブトン全部/', ->
    strToMatch      = 'bobからザブトン全部'
    expectedMatches = [ 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)の座布団全部/', ->
    strToMatch      = 'bobの座布団全部'
    expectedMatches = [ 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のざぶとん全部/', ->
    strToMatch      = 'bobのざぶとん全部'
    expectedMatches = [ 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のザブトン全部/', ->
    strToMatch      = 'bobのザブトン全部'
    expectedMatches = [ 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)から座布団(\d+)枚/', ->
    strToMatch      = 'bobから座布団1枚'
    expectedMatches = [ 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からざぶとん(\d+)枚/', ->
    strToMatch      = 'bobからざぶとん1枚'
    expectedMatches = [ 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からザブトン(\d+)枚/', ->
    strToMatch      = 'bobからザブトン1枚'
    expectedMatches = [ 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)の座布団(\d+)枚/', ->
    strToMatch      = 'bobの座布団1枚'
    expectedMatches = [ 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のざぶとん(\d+)枚/', ->
    strToMatch      = 'bobのざぶとん1枚'
    expectedMatches = [ 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のザブトン(\d+)枚/', ->
    strToMatch      = 'bobのザブトン1枚'
    expectedMatches = [ 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)寒い/', ->
    strToMatch      = 'bob寒い'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)さむい/', ->
    strToMatch      = 'bobさむい'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)サムイ/', ->
    strToMatch      = 'bobサムイ'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)さみー/', ->
    strToMatch      = 'bobさみー'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、寒い/', ->
    strToMatch      = 'bob、寒い'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、さむい/', ->
    strToMatch      = 'bob、さむい'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、サムイ/', ->
    strToMatch      = 'bob、サムイ'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、さみー/', ->
    strToMatch      = 'bob、さみー'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) 寒い/', ->
    strToMatch      = 'bob 寒い'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) さむい/', ->
    strToMatch      = 'bob さむい'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) サムイ/', ->
    strToMatch      = 'bob サムイ'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) さみー/', ->
    strToMatch      = 'bob さみー'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)座布団何枚/', ->
    strToMatch      = 'bob座布団何枚'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)ざぶとん何枚/', ->
    strToMatch      = 'bobざぶとん何枚'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)ザブトン何枚/', ->
    strToMatch      = 'bobザブトン何枚'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)は座布団何枚/', ->
    strToMatch      = 'bobは座布団何枚'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'only slurps the final "は" in a username', ->
    strToMatch      = 'bobははは座布団何枚'
    expectedMatches = [ 'bobはは' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)はざぶとん何枚/', ->
    strToMatch      = 'bobはざぶとん何枚'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)はザブトン何枚/', ->
    strToMatch      = 'bobはザブトン何枚'
    expectedMatches = [ 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
