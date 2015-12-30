/*:
## Events…
…are three-part codey bits:
1. broadcaster of arguments (📡)
2. signal, which is those arguments
3. receiver of the signal, whose signature matches the signal (📻)

The name of events will typically be past tense, to denote that they *just* happened. Emoji come after the name, to denote whether they are broadcasters or receivers.
*/

struct Broadcaster {
   static var thingHappened📻: (Int -> ())?
   
   // Normally this would only be called from within a Broadcaster.
   func thingHappened📡(int: Int) {Broadcaster.thingHappened📻?(int)}
}

struct Receiver {
   init() {Broadcaster.thingHappened📻 = thingHappened📻}
   func thingHappened📻(int: Int) {print(int)}
}

Receiver()
Broadcaster().thingHappened📡(Int.max)
/*:
### Rationale for these Emoji
* 📡: An event is a signal being broadcast.
* 📻: A radio acquires a signal and does something meaningful with it.
### Possibilities
* 📡s might be functions or `MultiClosure`s.
* 📻s might be functions, closures, or `EquatableClosure`s.

Use the simplest thing that works, in each case.
*/
