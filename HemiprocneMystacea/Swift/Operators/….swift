infix operator … : EllipsisPrecedence

precedencegroup EllipsisPrecedence {
	associativity: left
	higherThan: BitwiseShiftPrecedence
}

///- Parameter process: a closure whose argument is `input`
///- Returns: `input`
///- Remark: Hold option, press ;
@discardableResult
public func … <Input>(
	input: Input,
	process: (Input) -> Void
) -> Input {
   process(input)
   return input
}

///- Returns: `transform(input)`
///- Remark: Hold option, press ;
public func … <Input, Output>(
	input: Input,
	transform: (Input) -> Output
) -> Output {
	return transform(input)
}
