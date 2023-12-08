import std/[strutils, sequtils, tables, algorithm, times, monotimes]
const input = slurp("input.txt").splitLines
let t1 = getMonoTime()

const cards = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']
type 
  Card = enum 
    A 
    K 
    Q 
    J 
    T 
    Nine 
    Eight 
    Seven 
    Six 
    Five 
    Four 
    Three 
    Two 
  HandType = enum 
    FiveOfAKind
    FourOfAKind
    FullHouse
    ThreeOfAKind
    TwoPair
    OnePair
    HighCard

converter charToCard(x: char): Card =
  for i, c in cards:
    if x == c: return i.Card

proc handToCountTable(hand: string): CountTable[Card] =
  for c in hand:
    result.inc c

var hands = input.mapIt((it.splitWhitespace[0], it.splitWhitespace[0].handToCountTable, it.splitWhitespace[1].parseInt))

proc findHandType(hand: CountTable[Card]): HandType =
  let diffcards = hand.len
  let highestcount = hand.largest[1]
  if diffcards == 2:
    if highestcount == 4: return FourOfAKind
    return FullHouse
  if diffcards == 3:
    if highestcount == 3: return ThreeOfAKind
    return TwoPair
  if diffcards == 4: return OnePair
  if diffcards == 1: return FiveOfAKind
  if diffcards == 5: return HighCard



proc handcmp(x, y: tuple[orig: string, hand: CountTable[Card], bid: int]): int =
  if x.hand.len < y.hand.len: 
    return 1
  if x.hand.len == y.hand.len:
    if x.hand.findHandType < y.hand.findHandType: 
      return 1
    if x.hand.findHandType == y.hand.findHandType: 
      for i in 0..4:
        if x.orig[i].charToCard.int < y.orig[i].charToCard.int: return 1
        if x.orig[i].charToCard.int > y.orig[i].charToCard.int: return -1
  if x.hand == y.hand: 
    return 0
  return -1



# proc rankHands(hands: seq[CountTable[char]]): seq[int] =
#   for hand in hands

var totalWinnings: int
hands.sort(handcmp)
for i, hand in hands:
  totalWinnings += (i+1) * hand[2]

let t2 = getMonoTime()
echo totalWinnings

echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"