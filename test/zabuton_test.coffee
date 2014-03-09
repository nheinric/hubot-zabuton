chai   = require 'chai'
sinon  = require 'sinon'
events = require 'events'
chai.use require 'sinon-chai'

expect     = chai.expect
brain      = new events.EventEmitter()
brain.data =
  zabuton: {}

expectedMatches = []
matchFunc = ( val ) ->
  emCopy  = expectedMatches.slice()
  matches = emCopy[0].match( val )
  return false if matches == null
  allMatched = true;
  for match in matches
    allMatched = false if match != emCopy.shift()
  return allMatched
regexpMatcher = sinon.match( matchFunc )

# todo Test point increment/decrement
# todo Test responses
describe 'hubot-zabuton', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      brain:   brain
    expectedMatches = []
    require('../src/zabuton')(@robot)

  it 'responds to /give (\d+) zabuton to (.*?)\s?$/i', ->
    expectedMatches = [ 'give 1 zabuton to bob', '1', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /give (.*?) (\d+) zabuton/i', ->
    expectedMatches = [ 'give bob 1 zabuton', 'bob', '1' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /take all zabuton from (.*?)\s?$/i', ->
    expectedMatches = [ 'take all zabuton from bob', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /take (\d+) zabuton from (.*?)\s?$/i', ->
    expectedMatches = [ 'take 1 zabuton from bob', '1', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /how many zabuton does (.*?) have\??/i', ->
    expectedMatches = [ 'how many zabuton does bob have', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)に座布団(\d+)枚/', ->
    expectedMatches = [ 'bobに座布団1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)にざぶとん(\d+)枚/', ->
    expectedMatches = [ 'bobにざぶとん1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)にザブトン(\d+)枚/', ->
    expectedMatches = [ 'bobにザブトン1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)から座布団全部/', ->
    expectedMatches = [ 'bobから座布団全部', 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からざぶとん全部/', ->
    expectedMatches = [ 'bobからざぶとん全部', 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からザブトン全部/', ->
    expectedMatches = [ 'bobからザブトン全部', 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)の座布団全部/', ->
    expectedMatches = [ 'bobの座布団全部', 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のざぶとん全部/', ->
    expectedMatches = [ 'bobのざぶとん全部', 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のザブトン全部/', ->
    expectedMatches = [ 'bobのザブトン全部', 'bob', '全部' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)から座布団(\d+)枚/', ->
    expectedMatches = [ 'bobから座布団1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からざぶとん(\d+)枚/', ->
    expectedMatches = [ 'bobからざぶとん1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)からザブトン(\d+)枚/', ->
    expectedMatches = [ 'bobからザブトン1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)の座布団(\d+)枚/', ->
    expectedMatches = [ 'bobの座布団1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のざぶとん(\d+)枚/', ->
    expectedMatches = [ 'bobのざぶとん1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)のザブトン(\d+)枚/', ->
    expectedMatches = [ 'bobのザブトン1枚', 'bob', '1枚' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)寒い/', ->
    expectedMatches = [ 'bob寒い', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)さむい/', ->
    expectedMatches = [ 'bobさむい', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)サムイ/', ->
    expectedMatches = [ 'bobサムイ', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)さみー/', ->
    expectedMatches = [ 'bobさみー', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、寒い/', ->
    expectedMatches = [ 'bob、寒い', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、さむい/', ->
    expectedMatches = [ 'bob、さむい', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、サムイ/', ->
    expectedMatches = [ 'bob、サムイ', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)、さみー/', ->
    expectedMatches = [ 'bob、さみー', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) 寒い/', ->
    expectedMatches = [ 'bob 寒い', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) さむい/', ->
    expectedMatches = [ 'bob さむい', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) サムイ/', ->
    expectedMatches = [ 'bob サムイ', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+) さみー/', ->
    expectedMatches = [ 'bob さみー', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)座布団何枚/', ->
    expectedMatches = [ 'bob座布団何枚', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)ざぶとん何枚/', ->
    expectedMatches = [ 'bobざぶとん何枚', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)ザブトン何枚/', ->
    expectedMatches = [ 'bobザブトン何枚', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)は座布団何枚/', ->
    expectedMatches = [ 'bobは座布団何枚', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'only slurps the final "は" in a username', ->
    expectedMatches = [ 'bobははは座布団何枚', 'bobはは' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)はざぶとん何枚/', ->
    expectedMatches = [ 'bobはざぶとん何枚', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to /(.+)はザブトン何枚/', ->
    expectedMatches = [ 'bobはザブトン何枚', 'bob' ]
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )
