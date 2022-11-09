import SwiftUI

/// A type with a localized textual representation.
public protocol LocalizedStringKeyConvertible {
  /// The key used to look up a string in a strings file or strings dictionary file.
  var localizedStringKey: LocalizedStringKey { get }
}

public extension LocalizedStringKeyConvertible where Self: CustomStringConvertible {
  var localizedStringKey: LocalizedStringKey { .init(stringLiteral: description) }
}

public extension Text {
  /// Displays localized content identified by a key.
  ///
  /// - Parameters:
  ///   - convertible: An instance that is convertible to the key for a string in the table identified by `tableName`.
  ///   - tableName: The name of the string table to search. If `nil`, use the
  ///     table in the `Localizable.strings` file.
  ///   - bundle: The bundle containing the strings file. If `nil`, use the
  ///     main bundle.
  ///   - comment: Contextual information about this key-value pair.
  init(
    _ convertible: some LocalizedStringKeyConvertible,
    tableName: String? = nil,
    bundle: Bundle? = nil,
    comment: StaticString? = nil
  ) {
    self.init(
      convertible.localizedStringKey,
      tableName: tableName,
      bundle: bundle,
      comment: comment
    )
  }
}
