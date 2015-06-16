'use strict'

{random} = Math
require '../helpers'
_ = require 'underscore'
Car = require './car'
Intersection = require './intersection'
Road = require './road'
Pool = require './pool'
Rect = require '../geom/rect'
settings = require '../settings'
dataCruzamento = require '../data'

class World
  constructor: ->
    @set {}

  @property 'instantSpeed',
    get: ->
      speeds = _.map @cars.all(), (car) -> car.speed
      return 0 if speeds.length is 0
      return (_.reduce speeds, (a, b) -> a + b) / speeds.length

  set: (obj) ->
    obj ?= {}
    @intersections = new Pool Intersection, obj.intersections
    @roads = new Pool Road, obj.roads
    @cars = new Pool Car, obj.cars
    @carsNumber = 0
    @dataCont = 0
    @probabilidadeCont = 0

  save: ->
    data = _.extend {}, this
    delete data.cars
    localStorage.world = JSON.stringify data
    link = document.createElement("a")
    alert(localStorage.world)
    link.download = "Dados"
    link.href = localStorage.world
    link.click()
    
  loadFile: ->
    data = settings.jsonCruzamento
    data = data and JSON.parse data
    return unless data?
    @clear()
    @carsNumber = data.carsNumber or 0
    for id, intersection of data.intersections
      @addIntersection Intersection.copy intersection
    for id, road of data.roads
      road = Road.copy road
      road.source = @getIntersection road.source
      road.target = @getIntersection road.target
      @addRoad road

  load: ->
    data = localStorage.world
    data = data and JSON.parse data
    return unless data?
    @clear()
    @carsNumber = data.carsNumber or 0
    for id, intersection of data.intersections
      @addIntersection Intersection.copy intersection
    for id, road of data.roads
      road = Road.copy road
      road.source = @getIntersection road.source
      road.target = @getIntersection road.target
      @addRoad road

  generateMap: (minX = -2, maxX = 2, minY = -2, maxY = 2) ->
    @clear()
    intersectionsNumber = (0.8 * (maxX - minX + 1) * (maxY - minY + 1)) | 0
    map = {}
    gridSize = settings.gridSize
    step = 5 * gridSize
    @carsNumber = 100
    while intersectionsNumber > 0
      x = _.random minX, maxX
      y = _.random minY, maxY
      unless map[[x, y]]?
        rect = new Rect step * x, step * y, gridSize, gridSize
        intersection = new Intersection rect
        @addIntersection map[[x, y]] = intersection
        intersectionsNumber -= 1
    for x in [minX..maxX]
      previous = null
      for y in [minY..maxY]
        intersection = map[[x, y]]
        if intersection?
          if random() < 0.9
            @addRoad new Road intersection, previous if previous?
            @addRoad new Road previous, intersection if previous?
          previous = intersection
    for y in [minY..maxY]
      previous = null
      for x in [minX..maxX]
        intersection = map[[x, y]]
        if intersection?
          if random() < 0.9
            @addRoad new Road intersection, previous if previous?
            @addRoad new Road previous, intersection if previous?
          previous = intersection
    null


  clear: ->
    @set {}

  onTick: (delta) =>
    throw Error 'delta > 1' if delta > 1
    @refreshCars()
    for id, intersection of @intersections.all()
      intersection.controlSignals.onTick delta
    for id, car of @cars.all()
      car.move delta
      @removeCar car unless car.alive

  refreshCars: ->
    #Procurar intersection
    intersection = _.find @intersections.all(), (intersection) -> intersection.id is "cruzamento"
    intersection.controlSignals.contTimeValue = 0 if intersection.controlSignals.contTimeValue > 43201
    @dataCont = 0 if intersection.controlSignals.contTimeValue is 0
    @probabilidadeCont = 0 if @dataCont is 0
    @alterarProbabilidade() if dataCruzamento.probalidadeTempo[@probabilidadeCont] < intersection.controlSignals.contTimeValue
    @addRandomCar() if dataCruzamento.carAddSec[@dataCont] < intersection.controlSignals.contTimeValue
    #@addRandomCar() if @cars.length < @carsNumber
    #@removeRandomCar() if @cars.length > @carsNumber

  addRoad: (road) ->
    @roads.put road
    road.source.roads.push road
    road.target.inRoads.push road
    road.update()

  getRoad: (id) ->
    @roads.get id

  addCar: (car) ->
    @cars.put car

  getCar: (id) ->
    @cars.get(id)

  removeCar: (car) ->
    @cars.pop car

  addIntersection: (intersection) ->
    @intersections.put intersection

  getIntersection: (id) ->
    @intersections.get id
    
  choiceRoad= (road, idFind) ->
    road.id = idFind

  alterarProbabilidade: ->
    settings.direcao.acucena = dataCruzamento.probabilidade[dataCruzamento.probalidadeTempo[@probabilidadeCont]].acucena
    settings.direcao.fatima = dataCruzamento.probabilidade[dataCruzamento.probalidadeTempo[@probabilidadeCont]].fatima
    settings.direcao.centro = dataCruzamento.probabilidade[dataCruzamento.probalidadeTempo[@probabilidadeCont]].centro
    settings.direcao.nazare = dataCruzamento.probabilidade[dataCruzamento.probalidadeTempo[@probabilidadeCont]].nazare
    @probabilidadeCont++
  
  addRandomCar: ->
    #road = _.sample @roads.all()
    @dataCont += 1
    road = null
    if settings.experiment
      r = (random() * 1000) % 100 + 1
      sumF = settings.direcao.acucena + settings.direcao.fatima
      sumC = sumF + settings.direcao.centro
      sumN = sumN + settings.direcao.nazare
      if r <= settings.direcao.acucena
        road = _.find @roads.all(), (road) -> road.id is 'roadAcucena1' 
      else
        if r <= sumF
          road = _.find @roads.all(), (road) -> road.id is 'roadFatima1' 
        else
          if r <= sumC
            road = _.find @roads.all(), (road) -> road.id is 'roadCentro1'
          else
            road = _.find @roads.all(), (road) -> road.id is 'roadNazare1'
      
    
    if road?
      lane = _.sample road.lanes
      @addCar new Car lane if lane?

  removeRandomCar: ->
    car = _.sample @cars.all()
    if car?
      @removeCar car

module.exports = World
