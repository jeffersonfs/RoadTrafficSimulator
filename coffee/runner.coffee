#!/usr/bin/env coffee
'use strict'

require './helpers'
World = require './model/world'
settings = require './settings'

measureAverageSpeed = (carNumber) ->
  
  world = new World()
  #world.generateMap()
  world.loadFile()
  world.carsNumber = carNumber
  results = []
  j = 0
  for i in [0..3000]
    settings.lightsFlipInterval = 10000
    world.onTick 0.1
    # console.log world.instantSpeed
    results.push world.instantSpeed
  (results.reduce (a, b) -> a + b) / results.length

#result = measureAverageSpeed()
#console.log 'result', result

#settings.lightsFlipInterval = 2
#result = measureAverageSpeed()
#console.log 'result', result

#settings.lightsFlipInterval = 3
#result = measureAverageSpeed()
#console.log 'result', result

#settings.lightsFlipInterval = 4
#result = measureAverageSpeed()
#console.log 'result', result


for i in [60..60]
  for j in [10..270]
    settings.lightsFlipInterval = i
    result = measureAverageSpeed(j)
    console.log i , j , result*3.6
