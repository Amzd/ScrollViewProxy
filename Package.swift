// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScrollViewProxy",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v13),
        .tvOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ScrollViewProxy",
            targets: ["ScrollViewProxy"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect.git", from: "0.1.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ScrollViewProxy",
            dependencies: ["Introspect"]),
//        .testTarget(
//            name: "ScrollViewProxyTests",
//            dependencies: ["ScrollViewProxy"]),
    ]
)
