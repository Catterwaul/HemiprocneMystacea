/*:
## Plurality: **s** versus 📦
Defer to **s** if it makes sense, but use 📦 when you might otherwise be tempted to use another generic "suffix" like “data”. Usually, something that warrants 📦 will be a tuple.
### Pronunciation: "Package" 
"Box" would work but it's called "Package" in the Emoji picker so "package" is better.
*/
let number = 1
let numbers = [1, 2]
let number📦 = (
   values: [1, 2],
   name: "Onetue"
)
/*:
If it’s a typealias and will be reused, use PascalCase.
*/
typealias Number📦 = (
   values: [Int],
   name: String
)

/*:
## Use 🔗 when a grouped name isn't clearer
### Pronunciation: "Link"
"🖇" was considered but renders thinly so was decided against.
*/
let bool🔗string = (true, "Probably something sorta related")

/*:
## 🍲: A tuple representing the parameters/arguments of a function.
### Pronunciation: "Food". Emoji name: "Pot of food".
*/
typealias Function🍲 = (bool: Bool, int: Int, string: String)
func function(function🍲: Function🍲) {}
let function🍲 = Function🍲(
   bool: true,
   int: 800,
   string: "Groon"
)
function(function🍲)
