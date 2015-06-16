'use strict'

{random} = Math
require '../helpers'
settings = require '../settings'

class ControlSignals
  constructor: (@intersection) ->
    @time = 0
    @flipMultiplier = 1 + (random() * 0.4 - 0.2) # 0.8 - 1.2
    @stateNum = 0
    @contTime = 0

  states: [
    ['L', '', 'L', ''],
    ['FR', '', 'FR', ''],
    ['', 'L', '', 'L'],
    ['', 'FR', '', 'FR']
  ]

  @STATE = [RED: 0, GREEN: 1]
    
  @TYPES = [SIGNED: 0, NOT_SIGNED: 1]
  
  @property 'type',
    get: -> @TYPES.SIGNED
    
  signed: ->
    return true

  @property 'flipInterval',
    get: -> @flipMultiplier * settings.lightsFlipInterval

  @property 'contTimeValue',
   get: -> @contTime

  _decode: (str) ->
    state = [0, 0, 0]
    state[0] = 1 if 'L' in str
    state[1] = 1 if 'F' in str
    state[2] = 1 if 'R' in str
    state

  @property 'state',
    get: ->
      stringState = @states[@stateNum % @states.length]
      if @intersection.roads.length <= 2
        stringState = ['LFR', 'LFR', 'LFR', 'LFR']
      (@_decode x for x in stringState)

  flip: ->
    @stateNum += 1

  onTick: (delta) =>
    @time += delta
    @contTime += delta
    if @time > @flipInterval
      @flip()
      @time -= @flipInterval

module.exports = ControlSignals
