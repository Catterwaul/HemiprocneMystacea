import struct Foundation.PersonNameComponents

extension PersonNameComponents: Comparable {
  public static func < (components0: Self, components1: Self) -> Bool {
    var fallback: Bool {
      [\PersonNameComponents.givenName, \.middleName].contains {
        Optional(
          optionals: (components0[keyPath: $0], components1[keyPath: $0])
        )
        .map(<)
        ?? false
      }
    }

    switch (components0.familyName, components1.familyName) {
    case let (familyName0?, familyName1?):
      return familyName0.isLessThan(familyName1, whenEqual: fallback)
    case (let familyName0?, nil):
      return components1.givenName.map { givenName1 in
        familyName0.isLessThan(givenName1, whenEqual: fallback)
      } ?? fallback
    case (nil, let familyName1?):
      return components0.givenName.map { givenName0 in
        givenName0.isLessThan(familyName1, whenEqual: fallback)
      } ?? fallback
    case (nil, nil):
      return fallback
    }
  }
}
