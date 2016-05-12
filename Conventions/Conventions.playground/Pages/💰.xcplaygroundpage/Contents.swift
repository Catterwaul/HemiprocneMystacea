/*:
Sometimes, using an parameter name does not add meaning. Frequently, this will be the case with generic functions with no, or very nonrestrictive, constraints. Closures can currently utilize `$0` for such parameters, but Swift doesn't yet allow us to omit parameter names in functions, and we can't begin parameter names with `$`. Emulate that and call attention to the fact that it's not official notation, by using a `💰` instead.
*/
func write
<🃏>
(💰0: 🃏) {
	print(💰0)
}
write("✍️")

/// Future Swift?
// func write($) {print(.0)}
/*:
Internal parameter names can't be enforced via protocols. This would be a great place to introduce a unified and simpler syntax. So, instead of this…
*/
protocol Protocol {
	func ƒ(
		_ lie1: Int,
		_ lie2: Int
	)
}

struct Struct: Protocol {
	func ƒ(
		💰0: Int,
		_ 💰1: Int
	) {
		print(
			💰0,
			💰1
		)
	}
}

Struct().ƒ(
	2,
	3
)
/*:
…We'd have this, which both takes away the lies, and stops us from having to waste cognitive resources on naming things that don't warrant names.
*/
/*
protocol Protocol {
	func ƒ(
		Int,
		Int
	)
}

struct Struct: Protocol {
	func ƒ(
		Int,
		Int
	) {
		print(
			$0,
			$1
		)
	}
}
*/