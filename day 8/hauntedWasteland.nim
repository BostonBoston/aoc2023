import std/[strutils, sequtils, strscans, tables, math, times, monotimes]
const input = slurp("input.txt")
let t1 = getMonoTime()

const endpoint = "ZZZ"
type 
  Node = tuple[left: string, right: string]

var 
  nodes: Table[string, Node]
  nodesA: seq[string]
  counts: seq[int]


let instructions = input.split("\n\n")[0]
for line in input.split("\n\n")[1].splitLines:
  var name, left, right: string
  if scanf(line, "$+ = ($+, $+)", name, left, right):
    nodes[name] = (left, right)
    if name.endsWith('A'): nodesA.add name

counts.setLen(nodesA.len)

proc phase(curnode: var string, stepcount: var int, endpointTest: proc (x: string): bool): bool =
  for dir in instructions:
    if endpointTest(curnode): return true
    let (left, right) = nodes[curnode]
    if dir == 'L': curnode = left
    else: curnode = right
    inc stepcount

var stepcountp1: int = 0
var curnode: string = "AAA"

var state: bool = false
while not state:
  state = phase(curnode, stepcountp1) do (x: string) -> bool: 
    x == endpoint 

for i, node in nodesA:
  var state: bool = false
  var curnode: string = node
  var stepcount: int = 0
  while not state:
    state = phase(curnode, stepcount) do (x: string) -> bool:
      x.endsWith('Z')
  counts[i] = stepcount

let p2 = counts.foldl(int (a*b)/gcd(a, b))
let t2 = getMonoTime()

echo stepcountp1
echo p2

echo "This took " & $(((t2-t1).inNanoseconds.float)*1e-9) & " seconds"

