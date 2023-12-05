import parseutils, times, std/monotimes
import strutils

const input: seq[string] = slurp("input.txt").rsplit('\n')
const locs = [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)]

let t1 = getMonoTime()


template checkLoc(dataSet: seq[string], origin, loc: tuple[x: int, y: int]) =
  mixin hits
  if dataSet[(origin[1] + loc[1])][origin[0]+loc[0]].isDigit: hits.add (origin[0]+loc[0], origin[1] + loc[1])


proc findAdjacents(input: seq[string], x, y: int, isGear: bool): (seq[int], int) =
  var 
    hits: seq[tuple[x: int, y: int]] = newSeqOfCap[tuple[x: int, y: int]](8)

  for loc in locs: checkLoc(input, (x, y), loc)

  for hit in hits:
    var first: int = 0
    var i = hit.x
    while input[hit.y][i].isDigit:
      dec i
      if i < 0: break
    first = i+1

    var potential: int
    discard parseInt(input[hit.y], potential, first)
    if not result[0].contains(potential): result[0].add(potential) 
    if result[0].len == 2: result[1] = result[0][0] * result[0][1]
    # this works on the assumption that hits could contain multiple instances of the same part number 
    # but also assumes that the same part number will not appear twice for a given symbol

var partNumbers: seq[int]
var sumOfGearRatios, sumOfPartNumbers: int 
for y, line in input:
  for x, c in line:
    if not c.isDigit and c != '.':
      let result = findAdjacents(input, x, y, c == '*')
      partNumbers.add(result[0])
      sumOfGearRatios = sumOfGearRatios + result[1]
      # this also assumes any given part number is not touching more than one symbol

for pn in partNumbers:
  sumOfPartNumbers = sumOfPartNumbers + pn

let t2 = getMonoTime()

echo sumOfPartNumbers
echo sumOfGearRatios
echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds" 