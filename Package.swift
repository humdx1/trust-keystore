// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrustKeystore",
    products: [
        .library(
            name: "TrustKeystore",
            targets: ["TrustKeystore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/humdx1/trezor-crypto-ios", branch: "master"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", from: "1.0.0"),
        .package(url: "https://github.com/GigaBitcoin/secp256k1.swift.git", .upToNextMajor(from: "0.8.1")),
    ],
    targets: [
        .target(
            name: "TrustKeystore",
            dependencies: ["CryptoSwift", .product(name: "TrezorCrypto", package: "trezor-crypto-ios"), .product(name: "secp256k1", package: "secp256k1.swift")],
            path: "./Sources"),
        .testTarget(
            name: "TrustKeystoreTests",
            dependencies: ["TrustKeystore"],
            path: "./Tests")
    ],
    swiftLanguageVersions: [.v4]
)
