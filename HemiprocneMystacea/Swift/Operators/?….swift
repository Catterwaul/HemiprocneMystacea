infix operator ?… {precedence 255}

///- Returns: `output(input)`, or `nil` if `input` is `nil`
///- Remark: Hold option, press ;
public func ?…
<Input, Output>(
	input: Input?,
	output: @noescape (Input) -> Output
) -> Output? {
	guard let input = input
	else {return nil}
	
	return output(input)
}

///- Returns: `output(input)`, or `nil` if `input` is `nil`
///- Remark: Hold option, press ;
public func ?…
<Input, Output>(
	input: Input?,
	output: @noescape (Input) -> Output?
) -> Output? {
	guard let input = input
	else {return nil}
	
	guard let output = output(input)
	else {return nil}
	
	return output
}
