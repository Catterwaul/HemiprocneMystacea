/*:
## 🔍:  A filter. Could be a static property of a type, or an instance property on a collection type.
* 🔍 refers back to the thing before the dot
### Examples:
* NSManagedObject+Self🍲.swift  -  inContext🔍
*/
import HemiprocneMystacea
func belowFive🔍(integers: [Int]) -> [Int] {
	return integers.filter{$0 < 5}
}

[2, 4, 6, 8]•belowFive🔍

/*:
## 🔎:  Indicates the trailing closure that follows is like a search field, providing terms for pattern matching.
##
##
### Examples:
* SequenceType.first🔎
*/