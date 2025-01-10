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
    static var voodooADNURL: String { "https://voodoo-adn-framework.s3.eu-west-1.amazonaws.com/iOS/Prod/2.5.0/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "ee163836b462af956eb1dad945ecc293dbd9cc8d0d484eab3f6df996e3f7fc22" }
    static var voodooADNName: String { "VoodooAdn" }
}
