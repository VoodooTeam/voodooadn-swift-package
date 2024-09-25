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
    static var voodooADNURL: String { "https://voodoo-adn-framework.s3.eu-west-1.amazonaws.com/iOS/Prod/2.3.45/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "69341a980f8bb2507cc826cc3b2e344cf1efcb85820d14b293220e3b5429c17b" }
    static var voodooADNName: String { "VoodooAdn" }
}
