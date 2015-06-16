'use strict'

settings =
  colors:
    background: '#97a1a1'
    redLight: 'hsl(0, 100%, 50%)'
    greenLight: '#85ee00'
    intersection: '#586970'
    intersectionNotSigned: '#ff0000'
    road: '#586970'
    roadMarking: '#bbb'
    hoveredIntersection: '#3d4c53'
    tempRoad: '#aaa'
    gridPoint: '#586970'
    grid1: 'rgba(255, 255, 255, 0.5)'
    grid2: 'rgba(220, 220, 220, 0.5)'
    hoveredGrid: '#f4e8e1'
  fps: 30
  lightsFlipInterval: 20
  gridSize: 14
  defaultTimeFactor: 5
  numberMaxForLane: 1
  experiment: true
  dataCity:
    car: 3
    mediumCar: 5
    bigCar: 16
    quantCar: 58.54
    quantMediumCar: 27.4
    quantBigCar: 14.06
  jsonCruzamento: '{"intersections":{"fatima":{"id":"fatima","rect":{"x":-42,"y":-178,"_width":14,"_height":14}},"nazare":{"id":"nazare","rect":{"x":-42,"y":110,"_width":14,"_height":14}},"centro":{"id":"centro","rect":{"x":45,"y":-14,"_width":14,"_height":14}},"cruzamento":{"id":"cruzamento","rect":{"x":-42,"y":-14,"_width":14,"_height":14}},"acucena":{"id":"acucena","rect":{"x":-180,"y":-14,"_width":14,"_height":14}}},"roads":{"roadFatima1":{"id":"roadFatima1","source":"fatima","target":"cruzamento"},"roadFatima2":{"id":"roadFatima2","source":"cruzamento","target":"fatima"},"roadCentro1":{"id":"roadCentro1","source":"centro","target":"cruzamento"},"roadCentro2":{"id":"roadCentro2","source":"cruzamento","target":"centro"},"roadNazare1":{"id":"roadNazare1","source":"nazare","target":"cruzamento"},"roadNazare2":{"id":"roadNazare2","source":"cruzamento","target":"nazare"},"roadAcucena1":{"id":"roadAcucena1","source":"acucena","target":"cruzamento"},"roadAcucena2":{"id":"roadAcucena2","source":"cruzamento","target":"acucena"}},"carsNumber":100}'
  direcao:
    acucena: 25 
    fatima: 25
    nazare: 25
    centro: 25
  car:
    acucena: 
      car: 0.2
      mediumCar: 0.4
      bigCar: 0.01
    fatima: 
      car: 0.2
      mediumCar: 0.4
      bigCar: 0.01
    nazare:
      car: 0.2
      mediumCar: 0.4
      bigCar: 0.01
    centro:
      car: 0.2
      mediumCar: 0.4
      bigCar: 0.01
        
module.exports = settings
