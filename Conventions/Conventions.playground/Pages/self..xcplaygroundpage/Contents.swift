/*:
# When to use explicit "***`self.`***"
*/
/*:
## ***Don't*** use `self.` when it means “my “ or "self, "
This represents the vast majority of where `self.` can *optionally* be used, and is always redundant.
* ***my*** is meant before nouns
* ***self*** is meant before verbs
*/
struct Struct {
	let thing: Any
	// self.thing = "my thing"
	
	func doSomething() {}
	// self.doSomething = "Self, do something."
}
/*:
## ***Do*** use `self.` when it means "me"
When this applies is often non-obvious, due to incorrect names. For example, in **`SequenceType`**…
* .lazy = _me, lazily_
* .map = _me, mapped_
* .filter = _me, filtered_
* .reduce = _me, reduced_
*/
/*:
## ***Do*** use `self.` when it means "my self"
This interpretation may always come before a boolean-returning property or function; we haven't found contrary examples yet.
### Example: **`SequenceType.contains`**
* self.contains = _my self contains_
* same meaning as, but gramatically more correct than **_I contains_**
* Thanks to [Erica Sadun] for this example

[Erica Sadun]: http://ericasadun.com/2015/08/14/the-curious-case-of-the-self-in-the-night-swiftlang/

### Example: **`Set.isSubsetOf`**
* self.isSubsetOf(sequence) = _my self is subset of sequence_
*/
