/// Used to implement Equatable using a property
///
///- Parameter operand1: term for the right side of the ==
///- Parameter getProperty: property to get from both terms and equate
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property: Equatable
>(
	operand0: Operand,
	operand1🔗getProperty: (
		Operand,
		(Operand) -> Property
	)
) -> Bool {
	let operand1 = operand1🔗getProperty.0
	let getProperty = operand1🔗getProperty.1
	
	return getProperty(operand0) == getProperty(operand1)
}

/// Used to implement Equatable using 2 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter propertyGets: gets for properties to equate, from both terms
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property1: Equatable,
	Property2: Equatable
>(
	operand0: Operand,
	operand1🔗propertyGets: (
		Operand,
		(Operand) -> Property1,
		(Operand) -> Property2
	)
) -> Bool {
	let operand1 = operand1🔗propertyGets.0
	let propertyGets = operand1🔗propertyGets
	
	return operand0 == (operand1,
		propertyGets.1
	) && propertyGets.2(operand0) == propertyGets.2(operand1)
}

/// Used to implement Equatable using 3 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter propertyGets: gets for properties to equate, from both terms
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable
>(
	operand0: Operand,
	operand1🔗propertyGets: (
		Operand,
		(Operand) -> Property1,
		(Operand) -> Property2,
		(Operand) -> Property3
	)
) -> Bool {
	let operand1 = operand1🔗propertyGets.0
	let propertyGets = operand1🔗propertyGets
	
	return operand0 == (operand1,
		propertyGets.1,
		propertyGets.2
	) && propertyGets.3(operand0) == propertyGets.3(operand1)
}

/// Used to implement Equatable using 4 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter propertyGets: gets for properties to equate, from both terms
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable,
	Property4: Equatable
>(
	operand0: Operand,
	operand1🔗propertyGets: (
		Operand,
		(Operand) -> Property1,
		(Operand) -> Property2,
		(Operand) -> Property3,
		(Operand) -> Property4
	)
) -> Bool {
	let operand1 = operand1🔗propertyGets.0
	let propertyGets = operand1🔗propertyGets
	
	return operand0 == (operand1,
		propertyGets.1,
		propertyGets.2,
		propertyGets.3
	) && propertyGets.4(operand0) == propertyGets.4(operand1)
}

/// Used to implement Equatable using 5 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter propertyGets: gets for properties to equate, from both terms
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable,
	Property4: Equatable,
	Property5: Equatable
>(
	operand0: Operand,
	operand1🔗propertyGets: (
		Operand,
		(Operand) -> Property1,
		(Operand) -> Property2,
		(Operand) -> Property3,
		(Operand) -> Property4,
		(Operand) -> Property5
	)
) -> Bool {
	let operand1 = operand1🔗propertyGets.0
	let propertyGets = operand1🔗propertyGets
	
	return operand0 == (operand1,
		propertyGets.1,
		propertyGets.2,
		propertyGets.3,
		propertyGets.4
	) && propertyGets.5(operand0) == propertyGets.5(operand1)
}
