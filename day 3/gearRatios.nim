import strutils, times, std/monotimes

const input: seq[string] = slurp("input.txt").rsplit('\n')
const linelen = input[0].len

let t1 = getMonoTime()

proc findAdjacents(input: seq[string], x, y: int, isGear: bool): (seq[int], int) =
  var 
    hits: seq[tuple[x: int, y: int]] = newSeqOfCap[tuple[x: int, y: int]](8)

  if input[y-1][x-1].isDigit: hits.add (x-1, y-1)
  if input[y-1][x].isDigit: hits.add (x, y-1)
  if input[y-1][x+1].isDigit: hits.add (x+1, y-1)
  if input[y][x-1].isDigit: hits.add (x-1, y)
  if input[y][x+1].isDigit: hits.add (x+1, y)
  if input[y+1][x-1].isDigit: hits.add (x-1, y+1)
  if input[y+1][x].isDigit: hits.add (x, y+1)
  if input[y+1][x+1].isDigit: hits.add (x+1, y+1)

  for hit in hits:
    var first, last: int = 0
    var i = hit.x
    while input[hit.y][i].isDigit:
      dec i
      if i < 0: break
    first = i+1
    i = hit.x
    while input[hit.y][i].isDigit:
      inc i
      if i >= linelen: break
    last = i-1
    let potential = input[hit.y][first..last].parseInt
    if not result[0].contains(potential): result[0].add(potential) 
    if result[0].len == 2: result[1] = result[0][0] * result[0][1]
    # this works on the assumption that hits could contain multiple instances of the same part number 
    # but also assumes that the same part number will not appear twice for a given symbol

var partNumbers: seq[int]
var sumOfGearRatios, sumOfPartNumbers: int 
for y, line in input:
  for x, c in line:
    if not c.isDigit and c != '.' and c.byte != 0xd:
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