/// Used to implement Equatable using a property
///
///- ToDo: Add ability to use @noescape for the property, to the language.
///
///- Parameter .1: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
public func == <🃏, Property: Equatable>(
   _0: 🃏,
   _1🔗property: (🃏, 🃏 -> Property)
) -> Bool {
   let _1 = _1🔗property.0,
      property = _1🔗property.1
   return _0•property == _1•property
}

/// Used to implement Equatable using 2 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter .1: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
public func == <🃏,
   Property1: Equatable,
   Property2: Equatable
>(
   _0: 🃏,
   _1🔗properties: (🃏,
      🃏 -> Property1,
      🃏 -> Property2
   )
) -> Bool {
   let _1 = _1🔗properties.0,
      properties = _1🔗properties
   return _0 == (_1, properties.1)
      && _0•properties.2 == _1•properties.2
}

/// Used to implement Equatable using 3 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter .1: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
public func == <🃏,
   Property1: Equatable,
   Property2: Equatable,
   Property3: Equatable
>(
   _0: 🃏,
   _1🔗properties: (🃏,
      🃏 -> Property1,
      🃏 -> Property2,
      🃏 -> Property3
   )
) -> Bool {
   let _1 = _1🔗properties.0,
      properties = _1🔗properties
   return _0 == (_1,
      properties.1, properties.2
   ) && _0•properties.3 == _1•properties.3
}

/// Used to implement Equatable using 4 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter .1: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
public func == <🃏,
   Property1: Equatable,
   Property2: Equatable,
   Property3: Equatable,
   Property4: Equatable
>(
   _0: 🃏,
   _1🔗properties: (🃏,
      🃏 -> Property1,
      🃏 -> Property2,
      🃏 -> Property3,
      🃏 -> Property4
   )
) -> Bool {
   let _1 = _1🔗properties.0,
      properties = _1🔗properties
   return _0 == (_1,
      properties.1, properties.2, properties.3
   ) && _0•properties.4 == _1•properties.4
}

/// Used to implement Equatable using 5 properties
///
///- ToDo: Add ability to use @noescape for the properties, to the language.
///
///- Parameter .1: term for the right side of the ==
///- Parameter properties: properties to equate using • operator
///
///- Returns: whether all properties are equal
///
///- Experiment:
/// - 🔗: Stuff that's "linked" together in a tuple
public func == <🃏,
   Property1: Equatable,
   Property2: Equatable,
   Property3: Equatable,
   Property4: Equatable,
   Property5: Equatable
>(
   _0: 🃏,
   _1🔗properties: (🃏,
      🃏 -> Property1,
      🃏 -> Property2,
      🃏 -> Property3,
      🃏 -> Property4,
      🃏 -> Property5
   )
) -> Bool {
   let _1 = _1🔗properties.0,
      properties = _1🔗properties
   return _0 == (_1,
      properties.1, properties.2, properties.3, properties.4
   ) && _0•properties.5 == _1•properties.5
}
