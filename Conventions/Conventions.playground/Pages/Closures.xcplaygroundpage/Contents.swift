/*:
# Closures
Generally, storing a function in a closure should consist of using the function's name, but not parameter list.
*/
func write(stuff stuff: String) {
   print(stuff)
}

struct Struct {
   init(write: String -> ()) {
      self.write = write
   }
   
   let write: (stuff: String) -> ()
}

Struct(write: write).write(stuff: "🐹🍖🚀")

/*:
## Overloads
Closures cannot yet be overloaded. They also can't have default values, which sometimes causes related problems. Use the alternate characters named ***SMALL LEFT PARENTHESIS***, ***FULLWIDTH COMMA***, and ***SMALL RIGHT PARENTHESIS***, to deal with this. Inside of those hacky parentheses, use internal parameter names, not external.
*/
func count(from startingNumber: Int = 1, to endingNumber: Int) {
   (startingNumber...endingNumber).forEach{print($0)}
}

let count﹙startingNumber，endingNumber﹚: (from: Int, to: Int) -> () = count
count﹙startingNumber，endingNumber﹚(from: 2, to: 8)

let count﹙endingNumber﹚: (to: Int) -> () = {count(to: $0)}
count﹙endingNumber﹚(to: 4)