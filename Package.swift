// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pulsar",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Pulsar",
            targets: ["Pulsar"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Pulse", from: "4.2.4")
    ],
    targets: [
        .target(
            name: "Pulsar",
            dependencies: [
                "Pulse",
                .product(name: "PulseUI", package: "Pulse")
            ]
        )
    ]
)
