// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: Constants.voodooADNName,
    products: [
        .library(
            name: Constants.voodooADNName,
            targets: [Constants.voodooADNName])
    ],
    targets: [
        .binaryTarget(
            name: Constants.voodooADNName,
            url: Constants.voodooADNURL,
            checksum: Constants.voodooADNChecksum
        )
    ]
)

enum Constants {
    static var voodooADNURL: String { "https://voodoo-adn-framework-dev.s3.eu-west-1.amazonaws.com/iOS/Prod/2.3.43/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "835c2293a9610b1df23438a7fb34eac7a03f30a631d1ec74a37e11382cd9f2be" }
    static var voodooADNName: String { "VoodooAdn" }
}
