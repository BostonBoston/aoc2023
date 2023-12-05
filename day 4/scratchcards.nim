import std/[strutils, math, sequtils, intsets, monotimes, times]
const input = slurp("input.txt").rsplit('\n')
let t1 = getMonoTime()

var 
  cards: seq[int] = newSeq[int](input.len)
  totalPoints, totalCards: int

proc calcScore(n: int): int = 
  if n != 0: result = 2^(n-1)

for i, line in input:
  inc cards[i]
  let nums = line.split(": ")[1].split(" | ")
  let wins = (nums[0].splitWhitespace.map(parseInt).toIntSet * nums[1].splitWhitespace.map(parseInt).toIntSet).len
  
  totalPoints += wins.calcScore
  totalCards += cards[i]
  for j in i+1..i+wins: 
    cards[j] += cards[i]
  
let t2 = getMonoTime()

echo "Part1 ", totalPoints
echo "Part2 ", totalCards
echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds" 