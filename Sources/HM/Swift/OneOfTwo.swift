/// Given two options, choose only one.
public enum OneOfTwo<Option0, Option1> {
  case option0(Option0), option1(Option1)
}

public extension OneOfTwo {
  enum Error: Swift.Error {
    case both(Option0, Option1)
    case neither
  }

  /// - Throws: OneOfTwo<Option0, Option1>.Error
  init(_ option0: Option0?, _ option1: Option1?) throws {
    switch (option0, option1) {
    case let (option0?, option1?):
      throw Error.both(option0, option1)
    case (nil, nil):
      throw Error.neither
    case (let option0?, _):
      self = .option0(option0)
    case (_, let option1?):
      self = .option1(option1)
    }
  }
}
