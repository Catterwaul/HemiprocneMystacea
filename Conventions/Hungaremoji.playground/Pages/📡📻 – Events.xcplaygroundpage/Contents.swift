/*:
## Events…
…are three-part codey bits:
1. transmitter of arguments (📡)
2. signal, which is those arguments
3. receiver of the signal, whose signature matches the signal (📻)

The name of events will typically be past tense, to denote that they *just* happened. Emoji come before the name, to denote whether they are broadcasters or receivers.
*/
struct Transmitter {
	static var 📻thingHappened: (Int -> ())?
	
	// Normally this would only be called from within a Transmitter.
	func 📡thingHappened(int: Int) {
		Transmitter.📻thingHappened?(int)
	}
}

struct Receiver {
	init() {
		Transmitter.📻thingHappened = 📻thingHappened
	}
	
	func 📻thingHappened(int: Int) {
		print(int)
	}
}

Receiver()
Transmitter().📡thingHappened(Int.max)
/*:
### Rationale for these Emoji
* 📡: An event is a signal being transmitted.
* 📻: A radio receives a signal and does something meaningful with it.
### Pronunciation
* 📡: "Transmit"
* 📻: "Receive"
### Possibilities
* 📡s might be functions or `MultiClosure`s.
* 📻s might be functions, closures, or `EquatableClosure`s.

Use the simplest thing that works, in each case.
*/
