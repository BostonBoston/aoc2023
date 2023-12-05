import std/[strutils, tables, strscans, sequtils]
const input = slurp("input.txt").rsplit("\n\n")



### BEWARE
## This doesnt exactly work because of A: splitting the ranges doesnt seem to work
## additionally if it did work it would take a month to run.

var
  seeds, locations: seq[int]
  seedsToSoil, soilToFertilizer, fertilizerToWater, waterToLight: Table[int, int]
  lightToTempurature, tempuratureToHumidity, humidityToLocation: Table[int, int]


proc rangesToTable(table: var Table[int, int], source, dest, length: int) =
  for i in 0..length:
    table[source+i] = dest+i


seeds = input[0].split(": ")[1].splitWhitespace.map(parseInt)
echo seeds
echo input[1]

proc mapTable(table: var Table[int, int], mapn: int) =
  for map in input[mapn].split(":")[1].split(0x0A.char):
    var source, dest, length: int
    echo "before scanf"
    echo map
    if scanf(map, "$i $i $i", dest, source, length):
      echo "scanf ", source, " ", dest, " ", length
      rangesToTable(table, source, dest, length)
    echo "after scanf"
    

mapTable(seedsToSoil, 1)
mapTable(soilToFertilizer, 2)
mapTable(fertilizerToWater, 3)
mapTable(waterToLight, 4)
mapTable(lightToTempurature, 5)
mapTable(tempuratureToHumidity, 6)
mapTable(humidityToLocation, 7)

proc useTable(table: Table[int, int], key: int): int =
  try:
    result = table[key]
  except ValueError:
    result = key

for seed in seeds:
    locations.add(humidityToLocation.useTable(
                tempuratureToHumidity.useTable(
                lightToTempurature.useTable(
                waterToLight.useTable(
                fertilizerToWater.useTable(
                soilToFertilizer.useTable(
                seedsToSoil.useTable(
                seed))))))))
echo locations.min # not 11451287 too low