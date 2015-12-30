/// Used to implement Equatable using a property
///
///- ToDo: Add ability to use @noescape for the property, to the language.
///
///- Parameter right: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
func == <Any, Property: Equatable>(
   left: Any,
   right🔗property: (right: Any, Any -> Property)
) -> Bool {
   let right = right🔗property.right,
      property = right🔗property.1
   return left•property == right•property
}

/// Used to implement Equatable using 2 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter right: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
func == <Any,
   Property1: Equatable,
   Property2: Equatable
>(
   left: Any,
   right🔗properties: (right: Any,
      Any -> Property1,
      Any -> Property2
   )
) -> Bool {
   let right = right🔗properties.right,
      properties = right🔗properties
   return left•properties.1 == right•properties.1
      && left•properties.2 == right•properties.2
}

/// Used to implement Equatable using 3 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter right: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
func == <Any,
   Property1: Equatable,
   Property2: Equatable,
   Property3: Equatable
>(
   left: Any,
   right🔗properties: (right: Any,
      Any -> Property1,
      Any -> Property2,
      Any -> Property3
   )
) -> Bool {
   let right = right🔗properties.right,
      properties = right🔗properties
   return left•properties.1 == right•properties.1
      && left•properties.2 == right•properties.2
      && left•properties.3 == right•properties.3
}

/// Used to implement Equatable using 4 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter right: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
func == <Any,
   Property1: Equatable,
   Property2: Equatable,
   Property3: Equatable,
   Property4: Equatable
>(
   left: Any,
   right🔗properties: (right: Any,
      Any -> Property1,
      Any -> Property2,
      Any -> Property3,
      Any -> Property4
   )
) -> Bool {
   let right = right🔗properties.right,
      properties = right🔗properties
   return left•properties.1 == right•properties.1
      && left•properties.2 == right•properties.2
      && left•properties.3 == right•properties.3
      && left•properties.4 == right•properties.4
}

/// Used to implement Equatable using 5 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter right: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
func == <Any,
   Property1: Equatable,
   Property2: Equatable,
   Property3: Equatable,
   Property4: Equatable,
   Property5: Equatable
>(
   left: Any,
   right🔗properties: (right: Any,
      Any -> Property1,
      Any -> Property2,
      Any -> Property3,
      Any -> Property4,
      Any -> Property5
   )
) -> Bool {
   let right = right🔗properties.right,
      properties = right🔗properties
   return left•properties.1 == right•properties.1
      && left•properties.2 == right•properties.2
      && left•properties.3 == right•properties.3
      && left•properties.4 == right•properties.4
      && left•properties.5 == right•properties.5
}
