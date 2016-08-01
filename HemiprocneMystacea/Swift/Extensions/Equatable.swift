/// Used to implement Equatable using a property
///
///- Parameter operand1: term for the right side of the ==
///- Parameter property: property to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property: Equatable
>(
	operand0: Operand,
	operand1🔗property: (
		Operand,
		@noescape (Operand) -> Property
	)
) -> Bool {
	let
	operand1 = operand1🔗property.0,
	property = operand1🔗property.1
	
	return operand0…property == operand1…property
}

/// Used to implement Equatable using 2 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property1: Equatable,
	Property2: Equatable
>(
	operand0: Operand,
	operand1🔗properties: (
		Operand,
		@noescape (Operand) -> Property1,
		@noescape (Operand) -> Property2
	)
) -> Bool {
	let
	operand1 = operand1🔗properties.0,
	properties = operand1🔗properties
	
	return operand0 == (operand1,
		properties.1
	)
		&& operand0…properties.2 == operand1…properties.2
}

/// Used to implement Equatable using 3 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	Operand,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable
>(
	operand0: Operand,
	operand1🔗properties: (
		Operand,
		@noescape (Operand) -> Property1,
		@noescape (Operand) -> Property2,
		@noescape (Operand) -> Property3
	)
) -> Bool {
	let
	operand1 = operand1🔗properties.0,
	properties = operand1🔗properties
	
	return operand0 == (operand1,
		properties.1,
		properties.2
	)
		&& operand0…properties.3 == operand1…properties.3
}

/// Used to implement Equatable using 4 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
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
	operand1🔗properties: (
		Operand,
		@noescape (Operand) -> Property1,
		@noescape (Operand) -> Property2,
		@noescape (Operand) -> Property3,
		@noescape (Operand) -> Property4
	)
) -> Bool {
	let
	operand1 = operand1🔗properties.0,
	properties = operand1🔗properties
	
	return operand0 == (operand1,
		properties.1,
		properties.2,
		properties.3
	)
		&& operand0…properties.4 == operand1…properties.4
}

/// Used to implement Equatable using 5 properties
///
///- Parameter operand1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
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
	operand1🔗properties: (
		Operand,
		@noescape (Operand) -> Property1,
		@noescape (Operand) -> Property2,
		@noescape (Operand) -> Property3,
		@noescape (Operand) -> Property4,
		@noescape (Operand) -> Property5
	)
) -> Bool {
	let
	operand1 = operand1🔗properties.0,
	properties = operand1🔗properties
	
	return operand0 == (operand1,
		properties.1,
		properties.2,
		properties.3,
		properties.4
	)
		&& operand0…properties.5 == operand1…properties.5
}
