// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-pos",
    products: [
        .library(
            name: "POS",
            targets: ["POS"]),
    ],
    targets: [
        .target(
            name: "blake3",
            path: "Sources/chiapos/src/b3",
            exclude: [
                "blake3_avx2_x86-64_unix.S",
                "blake3_avx2.c",
                "blake3_avx512_x86-64_unix.S",
                "blake3_avx512.c",
                "blake3_sse41_x86-64_unix.S",
                "blake3_sse41.c",
            ],
            publicHeadersPath: "./",
            cSettings: [
                .define("BLAKE3_NO_AVX2", to: "1"),
                .define("BLAKE3_NO_AVX512", to: "1"),
                .define("BLAKE3_NO_SSE41", to: "1")
            ]),
        .target(
            name: "chiapos",
            path: "Sources/chiapos/src",
            exclude: [
                "b3",
                "cli.cpp",
                "../lib/FiniteStateEntropy/lib/huf_compress.c"
            ],
            publicHeadersPath: "./",
            cxxSettings: [
                .headerSearchPath("b3"),
                .headerSearchPath("../lib/include")
            ]),
        .target(
            name: "ObjCPOS",
            dependencies: ["chiapos", "blake3"],
            path: "Sources/ObjCPOS",
            cxxSettings: [
                .headerSearchPath("../chiapos/src"),
                .headerSearchPath("../chiapos/src/b3"),
                .headerSearchPath("../chiapos/lib/include")
            ]),
        .target(
            name: "POS",
            dependencies: ["ObjCPOS"]),
        .testTarget(
            name: "POSTests",
            dependencies: ["POS"]),
    ],
    cxxLanguageStandard: .cxx17
)
