'use strict'

{random} = Math
require '../helpers'
settings = require '../settings'
ControlSignals = require './control-signals'

class NotControlSignals extends ControlSignals

  states: [
    ['', '', '', ''],
    ['', '', '', ''],
    ['', '', '', ''],
    ['', '', '', '']
  ]


  signed: ->
    return false

  @property 'state',
    get: ->
      stringState = @states[@stateNum % @states.length]
      if @intersection.roads.length <= 2
        stringState = ['LFR', 'LFR', 'LFR', 'LFR']
      (@_decode x for x in stringState)


module.exports = NotControlSignals
