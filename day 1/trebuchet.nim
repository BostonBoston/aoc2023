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
    var first, last: string = "a"
    var dist: int = 0
    block outer:
      for i in 0..entry.len-1:
        let span = entry[0..i]
        for x, num in digits:
          if span.contains(num):
            first = $x
            dist = i
            break outer
          if span.contains($x):
            first = $x
            dist = i
            break outer
    block outer:     
      for i in countdown(entry.len-1, dist):
        let span = entry[i..entry.len-1]
        for x, num in digits:
          if span.contains(num):
            last = $x
            break outer
          if span.contains($x):
            last = $x
            break outer
    try:
      let num = parseInt(first & last)
      sum = sum + num 
    except: discard

  echo sum
let t2 = getMonoTime()

echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"

    
