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
    static var voodooADNChecksum: String { "cea4090429b860eb8a43c1a109b577496888d54b259f53f44cc22fe7b15b82a9" }
    static var voodooADNName: String { "VoodooAdn" }
}
