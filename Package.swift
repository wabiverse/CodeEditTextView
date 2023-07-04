// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "CodeEditTextView",
  platforms: [.macOS(.v13)],
  products: [
    .library(
      name: "CodeEditTextView",
      targets: ["CodeEditTextView"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/Wabi-Studios/STTextView.git",
      exact: "0.7.9"
    ),
    .package(
      url: "https://github.com/CodeEditApp/CodeEditLanguages.git",
      exact: "0.1.16"
    ),
    .package(
      url: "https://github.com/lukepistrol/SwiftLintPlugin",
      from: "0.2.2"
    ),
    .package(
      url: "https://github.com/ChimeHQ/TextFormation",
      from: "0.6.7"
    ),
  ],
  targets: [
    .target(
      name: "CodeEditTextView",
      dependencies: [
        "STTextView",
        "CodeEditLanguages",
        "TextFormation",
      ],
      plugins: [
        .plugin(name: "SwiftLint", package: "SwiftLintPlugin"),
      ]
    ),

    .testTarget(
      name: "CodeEditTextViewTests",
      dependencies: [
        "CodeEditTextView",
        "CodeEditLanguages",
      ]
    ),
  ]
)
