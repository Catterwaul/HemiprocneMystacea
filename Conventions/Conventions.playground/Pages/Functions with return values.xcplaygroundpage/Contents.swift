/*:
# Functions that return values can be…
## …Pseudo-initializers
**PascalCase** should be used when a function returns its name. The return value is a specialized type of the return type.
*/
struct Cat {
   init(color: String, cool: Bool = true) {
      self.color = color
      self.cool = cool
   }

   let
      color: String,
      cool: Bool
}

func OrangeCat() -> Cat {
   return Cat(color: "orange")
}

func UncoolCat(color: String) -> Cat {
   return Cat(color: color, cool: false)
}
/*:
## …Stand-ins for generic properties
Until Swift has generic properties, we have to use functions that stand in as their getters. Use `_get`, after the property name.
*/
func things_get<Thing>() -> [Thing] {
   let things: [Any] = [false, 0, true, 1]
   return things.flatMap{$0 as? Thing}
}
var bools: [Bool] {return things_get()}
bools
var ints: [Int] {return things_get()}
ints

/// Future Swift 
/* 
var things<Thing>: [Thing] {
   let things: [Any] = [false, 0, true, 1]
   return things.flatMap{$0 as? Thing}
}
var bools: [Bool] {return things}
var ints: [Int] {return things}
*/
/// …and even more-Future Swift?
/*
var things: [$] {
   let things: [Any] = [false, 0, true, 1]
   return things.flatMap{.0 as? $}
}
*/
/*:
## …Stand-ins for named subscripts

*/

/*:
## …Verbs
Normally, verb-functions don't return values. But Swift doesn't seem to have an accepted way, in source, to express when a function is a verb, yet also returns something. In these cases, use the `Returns` markup to document what will be returned, but don't include whatever that returned value is, in the function's name.
*/
struct Iterator {
   init(limit: Int) {self.limit = limit}
   
   ///- Returns: Current iteration
   @warn_unused_result
   mutating func iterate() -> Int? {
      iteration += 1
      return iteration > limit ? nil : iteration
   }
   
   private var iteration = 0
   private let limit: Int
}

var iterator = Iterator(limit: 2)
while let iteration = iterator.iterate() {}
