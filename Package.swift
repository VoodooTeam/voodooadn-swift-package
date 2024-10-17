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
    static var voodooADNURL: String { "https://voodoo-adn-framework.s3.eu-west-1.amazonaws.com/iOS/Prod/2.3.47/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "edf7f1e0dc86d12d673e72df74a06553db5a1da67cb45f6a81305757c03920a0" }
    static var voodooADNName: String { "VoodooAdn" }
}
