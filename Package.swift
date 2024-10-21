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
    static var voodooADNURL: String { "https://voodoo-adn-framework.s3.eu-west-1.amazonaws.com/iOS/Prod/2.3.48/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "8693b992df23f6086bc36acc24c3b0bebdf29e3e17d441ceb472cd8b551f626f" }
    static var voodooADNName: String { "VoodooAdn" }
}
