infix operator … {associativity left precedence 255}

///- Parameter ƒ: a closure whose argument is `input`
///- Returns: `input`
///- Remark: Hold option, press ;
@discardableResult
public func …
<Input>(
	input: Input,
	ƒ: @noescape (Input) -> ()
) -> Input {
   ƒ(input)
   return input
}

///- Returns: `transform(input)`
///- Remark: Hold option, press ;
public func …
<Input, Output>(
	input: Input,
	transform: @noescape (Input) -> Output
) -> Output {
	return transform(input)
}
