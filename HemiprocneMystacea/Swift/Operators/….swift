infix operator … {associativity left precedence 255}

///- Parameter process: a closure whose argument is `input`
///- Returns: `input`
///- Remark: Hold option, press ;
@discardableResult
public func … <Input>(
	input: Input,
	process: @noescape (Input) -> Void
) -> Input {
   process(input)
   return input
}

///- Returns: `transform(input)`
///- Remark: Hold option, press ;
public func … <Input, Output>(
	input: Input,
	transform: @noescape (Input) -> Output
) -> Output {
	return transform(input)
}
