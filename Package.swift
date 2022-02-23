// swift-tools-version:5.5

import PackageDescription

let names = [
  .hm,
  "SwiftUI", "UIKit",
  .xcTest
]

let package = Package(
  name: "HemiprocneMystacea",
  platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)],
  products: names.map {
    let name = $0.hm
    return .library(name: name, targets: [name])
  },
  dependencies: Package.Dependency.names.map {
    .package(url: "https://github.com/apple/\($0.swiftPrefixed)", .branch("main"))
  },
  targets: names.flatMap { frameworkName -> [Target] in
    var suffixedTarget: Target {
      .target(
        name: frameworkName.hm,
        dependencies: [.init(stringLiteral: .hm)],
        path: "Sources/\(frameworkName)"
      )
    }

    var testTarget: Target {
      let tests = "Tests"
      return .testTarget(
        name: "\(frameworkName.hm).\(tests)",
        dependencies: {
          var dependencies = [String.hm, .xcTest.hm]
          if frameworkName != .hm {
            dependencies.append(frameworkName.hm)
          }
          return dependencies.map(Target.Dependency.init)
        } (),
        path: "\(tests)/\(frameworkName)",
        resources: [.process("../Mousse with Mouse.png")]
      )
    }

    switch frameworkName {
    case .hm:
      return [
        .target(
          name: .hm,
          dependencies: Package.Dependency.names.map {
            .product(name: $0.capitalized, package: $0.swiftPrefixed)
          }
        ),
        testTarget
      ]
    case .xcTest:
      return [suffixedTarget]
    default:
      return [suffixedTarget, testTarget]
    }
  }
)

extension Package.Dependency {
  static let names = ["algorithms", "collections"]
}

extension String {
  static let hm = "HM"
  static let xcTest = "XCTest"

  var hm: String {
    self == .hm
      ? self
      : "\(self).\(Self.hm)"
  }

  var swiftPrefixed: String { "swift-\(self)" }
}
