// swift-tools-version:5.1

import PackageDescription

let hm = "HM"

extension String {
  var dependency: Target.Dependency { .init(stringLiteral: self) }
  var testsPath: String { "Tests/\(self)" }
  var withTestsTargetSuffix: String { "\(self).Tests" }
}

let nestedLibraries: [Product] =
  ["UIKit"]
    .map { frameworkName in
      let targetName = "\(frameworkName).\(hm)"
      return .library(name: targetName, targets: [targetName])
    }

let package = Package(
  name: "HemiprocneMystacea",
  platforms: [.iOS(.v13), .tvOS(.v13), .macOS(.v10_15)],
  products:
    [.library(name: hm, targets: [hm])]
    + nestedLibraries,
  targets:
    [ .target(name: hm),
      .testTarget(
        name: hm.withTestsTargetSuffix,
        dependencies: [hm.dependency],
        path: hm.testsPath
      )
    ]
    + nestedLibraries.flatMap {
      [ .target(
          name: $0.name,
          dependencies: [hm.dependency]
        ),
        .testTarget(
          name: $0.name.withTestsTargetSuffix,
          dependencies: [
            hm.dependency,
            $0.name.dependency
          ],
          path: $0.name.testsPath
        )
      ]
    }
)
