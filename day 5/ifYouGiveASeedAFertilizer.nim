import std/[strutils, tables, strscans, sequtils, sugar]
const input = slurp("input.txt").split("\n\n")
#const input = slurp("sample.txt").split("\r\n\r\n")




type
  Map = tuple[source, dest, length: int]
  Seed = tuple[start, length: int]

var
  seedsToSoil, soilToFertilizer, fertilizerToWater, waterToLight: seq[Map]
  lightToTempurature, tempuratureToHumidity, humidityToLocation: seq[Map]


proc rangesToTable(table: var Table[int, int], source, dest, length: int) =
  for i in 0..length:
    table[source+i] = dest+i


let seeds = input[0].split(": ")[1].splitWhitespace.map(parseInt)
let actualSeeds: seq[Seed] = collect:
  var i: int = -2
  while i < seeds.len-2:
    i += 2
    (start: seeds[i], length: seeds[i+1])
    
echo actualSeeds


proc mapTable(table: var seq[Map], mapn: int) =
  for map in input[mapn].split(":")[1].split(0x0A.char):
    var source, dest, length: int
    if scanf(map, "$i $i $i", dest, source, length):
      table.add (source: source, dest: dest, length: length)
    

mapTable(seedsToSoil, 1)
mapTable(soilToFertilizer, 2)
mapTable(fertilizerToWater, 3)
mapTable(waterToLight, 4)
mapTable(lightToTempurature, 5)
mapTable(tempuratureToHumidity, 6)
mapTable(humidityToLocation, 7)

proc useMap(table: seq[Map], key: int): int =
  for map in table:
    if (map.source..map.source+map.length-1).contains(key): 
      return map.dest + (key - map.source)
  return key

let locations = collect:
  for seed in seeds:
    humidityToLocation.useMap(
    tempuratureToHumidity.useMap(
    lightToTempurature.useMap(
    waterToLight.useMap(
    fertilizerToWater.useMap(
    soilToFertilizer.useMap(
    seedsToSoil.useMap(
    seed)))))))

var locations2: seq[int]
for seed in actualSeeds:
  for i in seed.start..<seed.start+seed.length:
    locations2.add(humidityToLocation.useMap(
                   tempuratureToHumidity.useMap(
                   lightToTempurature.useMap(
                   waterToLight.useMap(
                   fertilizerToWater.useMap(
                   soilToFertilizer.useMap(
                   seedsToSoil.useMap(
                  i))))))))
    if locations[locations.len-1] > locations2[locations.len-2]: break


echo locations.min 
echo locations2.min 
