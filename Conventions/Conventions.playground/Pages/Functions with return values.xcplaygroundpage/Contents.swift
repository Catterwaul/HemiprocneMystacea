/*:
# Functions that return values can be…
## …Pseudo-initializers
**camelCase_init** should be used when a function returns its name. (Until properties have real initializers, we'll pretend that they do, with a `_` instead of a `.`) The return value is a specialized type of the return type, but we don't use **PascalCase** due to the specialization not being enforced by the compiler. */
struct Cat {
	init(
		color: String,
		cool: Bool = true
	) {
		self.color = color
		self.cool = cool
	}
	
	let
		color: String,
		cool: Bool
}

func orangeCat_init() -> Cat {
	return Cat(color: "orange")
}

func uncoolCat_init(color: String) -> Cat {
	return Cat(
		color: color,
		cool: false
	)
}
/*:
## …Abstractions of initializers, or not!
Frequently, it's not important to know whether a function returns a new instance, an existing one, or a copy of an existing one. If there's a chance it doesn't exist already, use a method instead of a computed property.
*/
func cat(color: String) -> Cat {
	return Cat(color: color)
}
/*:
## …Stand-ins for generic properties
Until Swift has generic properties, we have to use functions that stand in as their getters. Use `_get`, after the property name.
*/
func things_get<Thing>() -> [Thing] {
	let things: [Any] = [
		false,
		0,
		true,
		1
	]
	return things.flatMap{$0 as? Thing}
}
var bools: [Bool] {return things_get()}
bools
var ints: [Int] {return things_get()}
ints

/// Future Swift 
/* 
var things<Thing>: [Thing] {
	let things: [Any] = [
		false, 
		0,
		true, 
		1
	]
	return things.flatMap{$0 as? Thing}
}
var bools: [Bool] {return things}
var ints: [Int] {return things}
*/
/// …and even more-Future Swift?
/*
var things: [$] {
	let things: [Any] = [
		false, 
		0, 
		true, 
		1
	]
	return things.flatMap{.0 as? $}
}
*/
/*:
## …Stand-ins for named subscripts
Swift doesn't yet have named subscripts. Until then, use parentheses as if they were square brackets.

*/
import UIKit
func cells(indexPath: NSIndexPath) -> UICollectionViewCell {
   // Real code would dequeue a cell based on `indexPath`
   return UICollectionViewCell()
}

/// Future Swift
/*
subscript cells[indexPath NSIndexPath]: UICollectionViewCell {
   // Dequeue a cell based on `indexPath`
}
*/
/// …and even more-Future Swift?
/*
subscript cells[NSIndexPath]: UICollectionViewCell {
   // Dequeue a cell based on .0
}
*/
/*:
## …Verbs
Normally, verb-functions don't return values. But Swift doesn't seem to have an accepted way, in source, to express when a function is a verb, yet also returns something. In these cases, use the `Returns` markup to document what will be returned, but don't include whatever that returned value is, in the function's name.
*/
struct Iterator {
	init(limit: Int) {
		self.limit = limit
	}
	
	///- Returns: Current iteration
	@warn_unused_result
	mutating func iterate() -> Int? {
		iteration += 1
		return iteration > limit
			? nil
			: iteration
	}
	
	private var iteration = 0
	private let limit: Int
}

var iterator = Iterator(limit: 2)
while let iteration = iterator.iterate() {}
