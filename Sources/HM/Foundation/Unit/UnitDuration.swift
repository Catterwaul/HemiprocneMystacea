import typealias Foundation.UnitDuration

public extension UnitDuration {
  static var days: UnitDuration {
    .init("day", 24, UnitDuration.hours)
  }

  static var weeks: UnitDuration {
    .init("week", 7, UnitDuration.days)
  }
}
