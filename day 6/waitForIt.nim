import std/[strutils, sequtils, math, monotimes]
import times as t
const input = slurp("input.txt")
let t1 = getMonoTime()

let times = input.splitLines[0].split(':')[1].splitWhitespace.map(parseInt)
let distances = input.splitLines[1].split(':')[1].splitWhitespace.map(parseInt)

let realtime = times.mapIt($it).join.parseInt
let realdistance = distances.mapIt($it).join.parseInt

iterator items(t: tuple[x, y: seq[int]]): (int, int) =
  doAssert t.x.len == t.y.len
  for i in 0..<t.x.len:
    yield (t.x[i], t.y[i])

proc calcWinRange(time, record: float): (int, int) =
  let first = (((time*(-1))+sqrt(time^2-(4*(record))))/(-2))
  let last = (((time*(-1))-sqrt(time^2-(4*(record))))/(-2))
  result[0] = floor(first + 1).int
  result[1] = ceil(last - 1).int

var total: int = 1
var realtotal: int
for (time, distance) in (times, distances):
  let (l, h) = calcWinRange(time.float, distance.float)
  total *= (h - l) + 1
echo total

let (l, h) = calcWinRange(realtime.float, realdistance.float)
realtotal = (h-l) + 1
echo realtotal

let t2 = getMonoTime()

echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"