/*:
# Functions that do not return values can be…
## …Verbs
Verbs do not take arguments.
*/
func write() {}
/*:
## …Predicates
A verb and its direct object will both be outside an empty parameter list, when that object does not need to vary, and therefore not be passed as an argument. Articles (such as the "a" in "a sentence") are not used.
*/
func writeSentence() {}
/*:
When the direct object does need to be an argument, it will have the same parameter name internally and externally. Currently, Swift uses the wrong default for this, so we must type the name twice.

Only the verb remains outside the parentheses.
*/
func write(sentence sentence: String) {}
/*:
Sometimes giving a direct object a parameter name does not add meaning. Frequently, this will be the case with generic functions with no, or very nonrestrictive, constraints. Closures currently utilize `$0` for this, but Swift doesn't yet allow us to omit parameter names in functions, and we can't begin parameter names with $. Use `_0` instead of `_$0`, because closures should use the term `.0`, instead of `$0`. Assume that as Swift improves, your underscores will eventually becoming dots, or at least dollar signs, with no correspongding manual parameter name.
*/
func write<🃏>(_0: 🃏) {print(_0)}
write("✍️")

/// Future Swift?
// func write($) {print(.0)}
/*:
Indirect objects need external parameter names, but not necessarily internal ones. The external parameter names will  either be…
### …Prepositions…
*/
func write(to buddy: AnyObject) {}
func write<🃏>(to _0: 🃏) {}
/*:
### …or Prepositions and their objects.
When this happens, the corresponding interal parameter name will be the same, but with the preposition removed.
*/
func write(toBuddy buddy: AnyObject) {}
