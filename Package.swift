// swift-tools-version:5.2

import PackageDescription

let hm = "HM"
let extendedFrameworkNames = ["SwiftUI", "UIKit"]

extension String {
  var dependency: Target.Dependency { .init(stringLiteral: self) }
  var testsPath: String { "Tests/\(self)" }
  var withDotHM: String { "\(self).\(hm)" }
  var withTestsTargetSuffix: String { "\(self).Tests" }
}

let package = Package(
  name: "HemiprocneMystacea",
  platforms: [.iOS(.v13), .tvOS(.v13), .macOS(.v10_15)],
  products:
    [.library(name: hm, targets: [hm])]
    + extendedFrameworkNames.map {
      let productName = $0.withDotHM
      return .library(name: productName, targets: [productName])
    },
  targets:
    [ .target(name: hm),
      .testTarget(
        name: hm.withTestsTargetSuffix,
        dependencies: [hm.dependency],
        path: hm.testsPath
      )
    ]
    + extendedFrameworkNames.flatMap { name in
      [ .target(
        name: name.withDotHM,
          dependencies: [hm.dependency],
          path: "Sources/\(name)"
        ),
        .testTarget(
          name: name.withDotHM.withTestsTargetSuffix,
          dependencies: [
            hm.dependency,
            name.withDotHM.dependency
          ],
          path: name.testsPath
        )
      ]
    }
)
