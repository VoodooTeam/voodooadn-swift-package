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
    static var voodooADNChecksum: String {"c1fdc74b778caa34cee34878ebb7da4d985434b0b14819852b1602ad20bdefdf"
    }
    static var voodooADNName: String { "VoodooAdn" }
}
