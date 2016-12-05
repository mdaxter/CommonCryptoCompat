import PackageDescription

let package = Package(
    name: "CommonCrypto",
    dependencies: [
        .Package(url: "https://github.com/mdaxter/CryptoSwift.git", majorVersion: 0),
    ]
)
