import struct Foundation.PersonNameComponents

extension PersonNameComponents: Comparable {
  public static func < (components0: Self, components1: Self) -> Bool {
    var fallback: Bool {
      [\PersonNameComponents.givenName, \.middleName].contains {
        Optional(
          optionals: (components0[keyPath: $0], components1[keyPath: $0])
        )
        .map { $0.lowercased().isLessThan($1.lowercased(), whenEqual: false) }
        ?? false
      }
    }

    switch (
      components0.givenName?.lowercased(), components0.familyName?.lowercased(),
      components1.givenName?.lowercased(), components1.familyName?.lowercased()
    ) {
    case let (
      _, familyName0?,
      _, familyName1?
    ):
      return familyName0.isLessThan(familyName1, whenEqual: fallback)
    case (
      _, let familyName0?,
      let givenName1?, nil
    ):
      return familyName0.isLessThan(givenName1, whenEqual: fallback)
    case (
      let givenName0?, nil,
      _, let familyName1?
    ):
      return givenName0.isLessThan(familyName1, whenEqual: fallback)
    default:
      return fallback
    }
  }
}
