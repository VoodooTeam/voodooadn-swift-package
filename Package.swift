// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: Constants.voodooADNName,
    products: [
        .library(
            name: Constants.voodooADNName,
            targets: [Constants.voodooADNName]),
        .library(
            name: Constants.OMSDKVoodooName,
            targets: [Constants.OMSDKVoodooName])
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
    static var voodooADNURL: String { "https://framework.voodoo-adn.com/iOS/sdk/3.120.8/VoodooAdn.zip"}
    static var voodooADNChecksum: String { "05b546522bfc8c377b88b22c4899889930bcc4c4a658724d54324cc7603289bc" }
    static var voodooADNName: String { "VoodooAdn" }
    static var OMSDKVoodooURL: String { "https://framework.voodoo-adn.com/omsdk/ios/1.5.2/OMSDK_Voodooio.zip"}
    static var OMSDKVoodooChecksum: String { "97914ad08803ee58d564d182b515b62250e0edd6f1d8360060603040ae39ad59" }
    static var OMSDKVoodooName: String { "OMSDK_Voodooio" }
}
