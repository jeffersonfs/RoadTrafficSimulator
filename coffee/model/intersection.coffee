'use strict'

require '../helpers'
_ = require 'underscore'
ControlSignals = require './control-signals'
ControlSignals3 = require './control-signals3'
Rect = require '../geom/rect'

class Intersection
  constructor: (@rect) ->
    @id = _.uniqueId 'intersection'
    @roads = []
    @inRoads = []
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
