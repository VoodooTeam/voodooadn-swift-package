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
        ),
        .binaryTarget(
            name: Constants.OMSDKVoodooName,
            url: Constants.OMSDKVoodooURL,
            checksum: Constants.OMSDKVoodooChecksum
        )
    ]
)

enum Constants {
    static var voodooADNURL: String { "https://voodoo-adn-framework.s3.eu-west-1.amazonaws.com/iOS/Prod/3.0.997/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "fe5ef7f6ec43bfdab8a3b0ef861e6bae5ab0316452a5d422fcf219a57d8b9474" }
    static var voodooADNName: String { "VoodooAdn" }
    static var OMSDKVoodooURL: String { "https://framework.voodoo-adn.com/omsdk/ios/1.5.2/OMSDK_Voodooio.zip"}
    static var OMSDKVoodooChecksum: String { "97914ad08803ee58d564d182b515b62250e0edd6f1d8360060603040ae39ad59" }
    static var OMSDKVoodooName: String { "OMSDK_Voodooio" }
}
