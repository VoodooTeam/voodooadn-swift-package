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
    static var voodooADNChecksum: String {"11c77bfd81b9facc5da194ca507907045ce12ffa417955c5109ece36a7b34a55"
    }
    static var voodooADNName: String { "VoodooAdn" }
}
