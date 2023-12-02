
import strutils, std/monotimes, times
const input: seq[string] = slurp("input.txt").rsplit('\n')
let t1 = getMonoTime()

type Game = object
  id: int
  reveals: seq[string]
  red, green, blue: int = 0

var
  games: seq[Game] = newSeqOfCap[Game](input.len)
  sum: int
  sum2: int



for i, line in input: 
  games.add Game(id: line.split(':')[0].split(' ')[1].parseInt, reveals: line.split(':')[1].rsplit(';'))

for i, game in games:
  for reveal in game.reveals:
    for color in reveal.rsplit(','):
      if color.contains("red"):
        let count = color[1..color.len-5].strip.parseInt
        if count > games[i].red: games[i].red = count
      elif color.contains("green"):
        let count = color[1..color.len-6].strip.parseInt
        if count > games[i].green: games[i].green = count
      elif color.contains("blue"):
        let count = color[1..color.len-6].strip.parseInt
        if count > games[i].blue: games[i].blue = count

for i in 0..games.len-1:
  sum2 = sum2 + (games[i].red * games[i].green * games[i].blue)
  if games[i].red <= 12:
    if games[i].green <= 13:
      if games[i].blue <= 14:
        sum = sum + games[i].id

let t2 = getMonoTime()

echo sum
echo sum2
echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"
 # :)


        


