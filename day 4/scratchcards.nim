import std/[strutils, math, sequtils, intsets, monotimes, times]
const input = slurp("input.txt").rsplit('\n')
let t1 = getMonoTime()

type Card = object 
  id, count: int
  winningNumbers, ourNumbers: IntSet


var 
  cards: seq[Card] = newSeqOfCap[Card](input.len)
  totalPoints, totalCards: int

for i, line in input:
  let nums = line.split(": ")[1].split(" | ")
  var tWin, tOur: IntSet

  tWin = nums[0].splitWhitespace.map(parseInt).toIntSet
  tOur = nums[1].splitWhitespace.map(parseInt).toIntSet
  cards.add Card(id: i+1, count: 1, winningNumbers: tWin, ourNumbers: tOur) 

proc calcScore(n: int): int = 
  if n != 0: result = 2^(n-1)

for card in cards:
  let matchingNumbers = (card.winningNumbers * card.ourNumbers).len
  totalPoints += matchingNumbers.calcScore
  totalCards += card.count
  for i in card.id+1..card.id+matchingNumbers: 
    cards[i-1].count += card.count

let t2 = getMonoTime()


echo "Part1 ", totalPoints
echo "Part2 ", totalCards
echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds" 