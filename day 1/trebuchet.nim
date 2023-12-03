import strutils, times, std/monotimes
const input: seq[string] = slurp("./input.txt").rsplit('\n')


let t1 = getMonoTime()
block part1:
  var sum: int

  for entry in input:
    var first, last: char = 'a'
    var dist: int = 0
    for i, c in entry:
      if c.isDigit: 
        first = c
        dist = i
        break
    for i in countdown(entry.len-1, dist):
      if entry[i].isDigit:
        last = entry[i]
        break
    let num: int = (((first.byte - 48)*10) + (last.byte - 48)).int
    sum = sum + num 

  echo sum

const digits = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

block part2:
  var sum: int

  for entry in input:
    var first, last: int = -1
    block outer:
      for i in 0..entry.len-1:
        let span = entry[0..i]
        let revspan = entry[entry.len-1-i..entry.len-1]
        for x, num in digits:
          if first != -1 and last != -1: break outer
          if span.contains(num) or span.contains($x):
            if first == -1: first = x*10
          if revspan.contains(num) or revspan.contains($x):
            if last == -1: last = x
    sum = sum + (first + last)

  echo sum
let t2 = getMonoTime()

echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"

    
