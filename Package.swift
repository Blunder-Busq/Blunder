// swift-tools-version:5.5
import PackageDescription

var package = Package(
    name: "Blunder",
    platforms: [ .macOS(.v11), .iOS(.v14) ],
    products: [
        .library(name: "Blunder", targets: ["Blunder"]),
        .executable(name: "blunder", targets: ["BlunderTool"]),
    ],
    dependencies: [
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(name: "Blunder"),
        .testTarget(name: "BlunderTests", dependencies: [
            "Blunder",
        ]),
        .executableTarget(name: "BlunderTool", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ])
    ]
)

// when testing on iOS simulator, the presence of the BlunderTool target causes a failure with:
// “xcodebuild: error: Scheme Blunder is not currently configured for the test action.”
// so we pre-process by making this true and removing the target
let excludeCLI = false

if excludeCLI {
    package.targets = package.targets.filter({
        $0.type != .executable
    })
    package.products = package.products.filter({
        $0.name != "busq"
    })
}
