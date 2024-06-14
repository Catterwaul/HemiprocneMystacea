// swift-tools-version:5.10

import Foundation
import PackageDescription

_ = Package(
  name: "HemiprocneMystacea",
  platforms: [.iOS(.v17), .tvOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: Product.Library.HM.allCases.map(\.library),
  dependencies: dependencies.map(\.package),
  targets: Product.Library.HM.allCases.flatMap(\.targets)
)

// MARK: -

extension Product.Library {
  enum HM: CaseIterable {
    case hm, realityKit, swiftUI, uiKit, xcTest
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
        .target(name: name, dependencies: dependencies.map(\.product)),
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
    case .realityKit:
      return "RealityKit"
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

// MARK: - Dependency

var dependencies: [Dependency]  {
  [ .apple(repositoryName: "algorithms"),
    .apple(repositoryName: "async-algorithms"),
    .apple(repositoryName: "collections"),
    .catterwaul(name: "Thrappture"),
    .catterwaul(name: "Tuplé", repositoryName: "Tuplay")
  ]
}

struct Dependency {
  let package: Package.Dependency
  let product: Target.Dependency
}

extension Dependency {
  static func apple(repositoryName: String) -> Self {
    .init(
      organization: "apple",
      name: repositoryName.split(separator: "-").map(\.capitalized).joined(),
      repositoryName: "swift-\(repositoryName)"
    )
  }

  static func catterwaul(name: String, repositoryName: String? = nil) -> Self {
    .init(organization: "Catterwaul", name: name, repositoryName: repositoryName ?? name)
  }

  private init(organization: String, name: String, repositoryName: String) {
    self.init(
      package: .package(
        url: "https://github.com/\(organization)/\(repositoryName)",
        branch: "main"
      ),
      product: .product(name: name, package: repositoryName)
    )
  }
}
