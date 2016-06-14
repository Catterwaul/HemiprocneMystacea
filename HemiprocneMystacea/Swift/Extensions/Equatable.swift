/// Used to implement Equatable using a property
///
///- ToDo: Add ability to use @noescape for the property, to the language.
///
///- Parameter 💰1: term for the right side of the ==
///- Parameter property: property to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	🃏,
	Property: Equatable
>(
	💰0: 🃏,
	💰1🔗property: (
		🃏,
		🃏 -> Property
	)
) -> Bool {
	let
		💰1 = 💰1🔗property.0,
		property = 💰1🔗property.1
	return 💰0…property == 💰1…property
}

/// Used to implement Equatable using 2 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter 💰1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	🃏,
	Property1: Equatable,
	Property2: Equatable
>(
	💰0: 🃏,
	💰1🔗properties: (
		🃏,
		🃏 -> Property1,
		🃏 -> Property2
	)
) -> Bool {
	let
		💰1 = 💰1🔗properties.0,
		properties = 💰1🔗properties
	return
		💰0 == (💰1,
			properties.1
		)
		&& 💰0…properties.2 == 💰1…properties.2
}

/// Used to implement Equatable using 3 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter 💰1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	🃏,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable
>(
	💰0: 🃏,
	💰1🔗properties: (
		🃏,
		🃏 -> Property1,
		🃏 -> Property2,
		🃏 -> Property3
	)
) -> Bool {
	let
		💰1 = 💰1🔗properties.0,
		properties = 💰1🔗properties
	return
		💰0 == (💰1,
			properties.1,
			properties.2
		)
		&& 💰0…properties.3 == 💰1…properties.3
}

/// Used to implement Equatable using 4 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter 💰1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	🃏,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable,
	Property4: Equatable
>(
	💰0: 🃏,
	💰1🔗properties: (
		🃏,
		🃏 -> Property1,
		🃏 -> Property2,
		🃏 -> Property3,
		🃏 -> Property4
	)
) -> Bool {
	let
		💰1 = 💰1🔗properties.0,
		properties = 💰1🔗properties
	return
		💰0 == (💰1,
			properties.1,
			properties.2,
			properties.3
		)
		&& 💰0…properties.4 == 💰1…properties.4
}

/// Used to implement Equatable using 5 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter 💰1: term for the right side of the ==
///- Parameter properties: properties to equate using … operator
///
///- Returns: whether all properties are equal
public func == <
	🃏,
	Property1: Equatable,
	Property2: Equatable,
	Property3: Equatable,
	Property4: Equatable,
	Property5: Equatable
>(
	💰0: 🃏,
	💰1🔗properties: (
		🃏,
		🃏 -> Property1,
		🃏 -> Property2,
		🃏 -> Property3,
		🃏 -> Property4,
		🃏 -> Property5
	)
) -> Bool {
	let
		💰1 = 💰1🔗properties.0,
		properties = 💰1🔗properties
	return
		💰0 == (💰1,
			properties.1,
			properties.2,
			properties.3,
			properties.4
		)
		&& 💰0…properties.5 == 💰1…properties.5
}