import std/[strutils, sequtils, sugar, times, monotimes]
from intsets import toIntSet, len
const input = slurp("input.txt").splitLines
let t1 = getMonoTime()

type 
  Evolution = seq[int]
  Extrapolations = seq[Evolution]
  Values = seq[Extrapolations]

proc extrapolate(x: Evolution): Evolution =
  for i in 0..<x.high:
    result.add(x[i+1] - x[i])

proc findFutureHistories(x: var Extrapolations): (int, int) =
  for i in countdown(x.high, 1):
    x[i-1].add(x[i][x[i].high] + x[i-1][x[i-1].high])
    x[i-1].insert(x[i-1][0] - x[i][0])
  result[0] = x[x.low][x[x.low].high]
  result[1] = x[0][0]

var values: Values = collect:
  for line in input:
    @[line.split.map(parseInt)]

var predictions: seq[int]
var history: seq[int]
for i, extrapolation in values:
  var current = extrapolation[0]
  while true:
    let e = extrapolate(current)
    values[i].add e
    current = e
    if e.toIntSet == [0].toIntSet: break
  let (future, past) = findFutureHistories(values[i])
  predictions.add future
  history.add past
let t2 = getMonoTime()

echo predictions.foldl(a+b)
echo history.foldl(a+b)

echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"