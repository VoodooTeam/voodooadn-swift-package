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
    static var voodooADNChecksum: String {"3b2a72971e4d3c52062cc113a27752007b28fc1a9c3f2d93d83328f2c40f89e6"
    }
    static var voodooADNName: String { "VoodooAdn" }
}
