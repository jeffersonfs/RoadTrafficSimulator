'use strict'

{random} = Math
require '../helpers'
settings = require '../settings'
ControlSignals = require './control-signals'

class ControlSignals3 extends ControlSignals

  states: [
        ['', '', '', 'LFR'],
        ['', 'LFR', '', ''],
        ['', '', 'LFR', ''],
        ['LFR', '', '', '']
  ]
    
  @property 'state',
    get: ->
      stringState = @states[@stateNum % @states.length]
      if @intersection.roads.length <= 2
        stringState = ['LFR', 'LFR', 'LFR', 'LFR']
      (@_decode x for x in stringState)

module.exports = ControlSignals3