//
//  Package.swift
//  Bubble
//
//  Created by Zhibek Rahymbekkyzy on 03.03.2022.
//

import PackageDescription

let package = Package(
    name: "GravitySPM",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "GravitySPM",
            targets: ["GravitySPM"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "GravitySPM",
            dependencies: []),
    ]
)
