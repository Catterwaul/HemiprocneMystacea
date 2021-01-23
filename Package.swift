// swift-tools-version:5.3

import PackageDescription

let names = [
  .hm,
  "SwiftUI", "UIKit",
  .xcTest
]

let package = Package(
  name: "HemiprocneMystacea",
  platforms: [.iOS(.v14), .macOS(.v11), .tvOS(.v14), .watchOS(.v7)],
  products: names.map {
    let name = $0.hm
    return .library(name: name, targets: [name])
  },
  targets:
    [.target(name: .hm)]
    + names.filter { $0 != .hm } .map { frameworkName in
      .target(
        name: frameworkName.hm,
        dependencies: .init(.hm),
        path: "Sources/\(frameworkName)"
      )
    }
    + names.filter { $0 != .xcTest } .map { name in
      let tests = "Tests"
      return .testTarget(
        name: "\(name.hm).\(tests)",
        dependencies: {
          let commonDependencies =
            [Target.Dependency](.hm)
            + .init(String.xcTest.hm)
          return name == .hm
            ? commonDependencies
            : commonDependencies + .init(name.hm)
        } (),
        path: "\(tests)/\(name)",
        resources: [.process("Mousse with Mouse.png")]
      )
    }
)

extension String {
  static let hm = "HM"
  static let xcTest = "XCTest"

  var hm: String {
    self == .hm
      ? self
      : "\(self).\(Self.hm)"
  }
}

extension Array where Element == Target.Dependency {
  init(_ name: String) {
    self = [.init(stringLiteral: name)]
  }
}
