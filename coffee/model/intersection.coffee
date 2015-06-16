'use strict'

{random} = Math
require '../helpers'
_ = require 'underscore'
ControlSignals = require './control-signals'
ControlSignals3 = require './control-signals3'
NotControlSignals = require './not-control-signals' 
Rect = require '../geom/rect'

class Intersection
  constructor: (@rect) ->
    @id = _.uniqueId 'intersection'
    @roads = []
    @inRoads = []
    #if (random()*100)%10 > 5 then @controlSignals = new ControlSignals3 this
    #else @controlSignals = new NotControlSignals this  
    @controlSignals = new ControlSignals3 this

  @copy: (intersection) ->
    intersection.rect = Rect.copy intersection.rect
    result = Object.create Intersection::
    _.extend result, intersection
    result.roads = []
    result.inRoads = []
    result.controlSignals = new ControlSignals3 result
    result

  toJSON: ->
    obj =
      id: @id
      rect: @rect

  update: ->
    road.update() for road in @roads
    road.update() for road in @inRoads

module.exports = Intersection
