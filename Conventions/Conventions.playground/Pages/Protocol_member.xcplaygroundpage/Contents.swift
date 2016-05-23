/*:
# `Protocol_member` syntax
When…
1. A member has its default implementation defined in a protocol extension
2. You want to use that default, within the member's concrete implementation 

…add the name of the protocol, in PascalCase, and an underscore, before the member's signature, in the protocol:
*/
protocol Protocol {}
extension Protocol {
	var Protocol_member: ()? {
		return nil
	}
}
struct ProtocollyStruct: Protocol {
	var member: ()? {
		return Protocol_member ?? ()
	}
}
ProtocollyStruct().member
/*:
## Why??! 
### Because of how protocol extensions differ from `super`.
Default implementations in protocols can be used similarly to `super` implementations, in classes, but not with the same syntax. Instead of actually using `super`…
*/
class Superclass {
	var string: String {
		return String(Superclass)
	}
}
final class Subclass: Superclass {
	override var string: String {
		return "\(String(Superclass)), \(super.string)'s 👶"
	}
}
Subclass().string
/*:
…you can cast the implementing type, to the protocol…
*/
protocol Stringy {}
extension Stringy {
	var string: String {
		return String(Stringy)
	}
}
struct StringyStruct: Stringy {
	var string: String {
		return "\(String(StringyStruct)), down with the \((self as Stringy).string)"
	}
}
StringyStruct().string
/*:
However, this can't be done, with **P**rotocols with **A**ssociated **T**ypes. (Uncomment the `self as Pat` line to see why not.)
*/
protocol Pat {
	associatedtype AssociatedType
}
extension Pat {
	var string: String {
		return "Pat"
	}
}
struct PattyStruct: Pat {
	typealias AssociatedType = ()
	
	var string: String {
//		self as Pat
		return "😾(self as PAT) isn't accessible, let alone Pat.string"
	}
}
/*:
And while you *can* cast a type to a non-PAT protocol to which it conforms, there is no way to access a default implementation of a member, if its signature is defined in the protocol.
*/
protocol ProtocolWithSignature {
	var string: String {get}
}
extension ProtocolWithSignature {
	var string: String {
		return String(ProtocolWithSignature)
	}
}
enum Stringynoom: ProtocolWithSignature {
	var string: String {
//		(self as ProtocolWithSignature).string
		return "(self as ProtocolWithSignature).string will recursively call this getter. 😿"
	}
}
/*:
Although there are times when you can rely on casting (*e.g. `Stringy`, above*), your concrete implementations will break, upon having to add relevant signatures to protocol definitions, or upon adding associated types to your protocols. This is too much to consider. Just use the `Protocol_member` syntax in all cases that match the description at the top of this page.*/
