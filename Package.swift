import PackageDescription

let package = Package(
    name: "CommonCrypto",
    dependencies: [
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", majorVersion: 0),
    ]
)
