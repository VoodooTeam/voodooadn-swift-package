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
    static var voodooADNURL: String { "https://voodoo-adn-framework.s3.eu-west-1.amazonaws.com/iOS/Prod/3.4.0/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "d0cec2b63417ac92b01432c80529c40c16d70171a43f3dec1ae8730c084ef6dc" }
    static var voodooADNName: String { "VoodooAdn" }
}
