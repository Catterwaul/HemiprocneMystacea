// swift-tools-version:5.9

import Foundation
import PackageDescription

_ = Package(
  name: "HemiprocneMystacea",
  platforms: [.iOS(.v17), .tvOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: Product.Library.HM.allCases.map(\.library),
  dependencies: Package.Apple.allCases.map(\.package),
  targets: Product.Library.HM.allCases.flatMap(\.targets)
)

// MARK: -

extension Product.Library {
  enum HM: CaseIterable {
    case hm, swiftUI, uiKit, xcTest
  }
}

extension Product.Library.HM {
  var library: Product {
    .library(name: hmSuffixedName, targets: [hmSuffixedName])
  }

  var targets: [Target] {
    var hmSuffixedTarget: Target {
      .target(
        name: hmSuffixedName,
        dependencies: [.init(stringLiteral: Self.hm.name)],
        path: "Sources/\(name)"
      )
    }

    var testTarget: Target {
      let tests = "Tests"
      return .testTarget(
        name: "\(hmSuffixedName).\(tests)",
        dependencies:
          // It's a Set, because for the base HM target,
          // `Self.hm.name` is the same as `hmSuffixedName`.
          ([Self.hm.name, Self.xcTest.hmSuffixedName, hmSuffixedName] as Set)
            .map(Target.Dependency.init),
        path: "\(tests)/\(name)",
        resources: [.process("../Mousse with Mouse.png")]
      )
    }

    switch self {
    case .hm:
      return [
        .target(
          name: name,
          dependencies: Package.Apple.allCases.map(\.product)
        ),
        testTarget
      ]
    case .xcTest:
      return [hmSuffixedTarget]
    default:
      return [hmSuffixedTarget, testTarget]
    }
  }

  private var name: String {
    switch self {
    case .hm:
      return "HM"
    case .swiftUI:
      return "SwiftUI"
    case .uiKit:
      return "UIKit"
    case .xcTest:
      return "XCTest"
    }
  }

  private var hmSuffixedName: String {
    switch self {
    case .hm:
      return name
    default:
      return "\(name).\(Self.hm.name)"
    }
  }
}

// MARK: -

extension Package {
  enum Apple: String, CaseIterable {
    case algorithms
    case asyncAlgorithms = "async-algorithms"
    case collections
  }
}

extension Package.Apple {
  var package: Package.Dependency {
   .package(url: "https://github.com/apple/" + swiftPrefixedName, branch: "main")
  }

  var product: Target.Dependency {
    .product(
      name: rawValue.split(separator: "-").map(\.capitalized).joined(),
      package: swiftPrefixedName
    )
  }

  private var swiftPrefixedName: String { "swift-" + rawValue }
}
