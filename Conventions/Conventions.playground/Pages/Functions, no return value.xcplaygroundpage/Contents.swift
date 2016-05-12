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
Indirect objects need external parameter names, but not necessarily internal ones. The external parameter names will  either be…
### …Prepositions…
*/
func write(to buddy: AnyObject) {}
func write
<🃏>
(to 💰0: 🃏) {}
/*:
### …or Prepositions and their objects.
When this happens, the corresponding interal parameter name will be the same, but with the preposition removed.
*/
func write(toBuddy buddy: AnyObject) {}
