
import strutils, std/monotimes, times
const input: seq[string] = slurp("input.txt").rsplit('\n')
let t1 = getMonoTime()

type Game = object
  id: int
  red, green, blue: int = 0

var
  games: seq[Game] = newSeqOfCap[Game](input.len) # after writing the second comment I added the newSeqOfCap call which dropped the runtime from 0.027 to 0.02
  sum: int
  sum2: int


# I originally had this split into two loops, where the seconds loop would loop over the games seq and do the color matching and directly assign to that Game in the seq.
# that original loop was actually faster, I assume because it did not need to alocate red, green and blue every loop as i was assigning with games[i].red = count etc

for i, line in input: 
  let id = line.split(':')[0].split(' ')[1].parseInt
  let reveals = line.split(':')[1].rsplit(';')
  var red, green, blue: int = 0
  for reveal in reveals:
    let colors = reveal.rsplit(',')
    for color in colors:
      if color.contains("red"):
        let count = color[1..color.len-5].strip.parseInt
        if count > red: red = count
      elif color.contains("green"):
        let count = color[1..color.len-6].strip.parseInt
        if count > green: green = count
      elif color.contains("blue"):
        let count = color[1..color.len-6].strip.parseInt
        if count > blue: blue = count

  games.add Game(id: id, red: red, green: green, blue: blue)


for i in 0..games.len-1:
  let power = games[i].red * games[i].green * games[i].blue
  sum2 = sum2 + power
  if games[i].red <= 12:
    if games[i].green <= 13:
      if games[i].blue <= 14:
        sum = sum + games[i].id

let t2 = getMonoTime()

echo sum
echo sum2
echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"


        


