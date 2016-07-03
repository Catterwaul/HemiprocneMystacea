infix operator ?… {precedence 255}

///- Returns: `transform(input)`, or `nil` if `input` is `nil`
///- Remark: Hold option, press ;
@discardableResult
public func ?…
<Input, Output>(
	input: Input?,
	transform: @noescape (Input) -> Output
) -> Output? {
	guard let input = input
	else {return nil}
	
	return transform(input)
}

///- Returns: `transform(input)`, or `nil` if `input` is `nil`
///- Remark: Hold option, press ;
public func ?…
<Input, Output>(
	input: Input?,
	transform: @noescape (Input) -> Output?
) -> Output? {
	guard let input = input
	else {return nil}
	
	guard let output = transform(input)
	else {return nil}
	
	return output
}
