# building with default toolchain
#
# xcodebuild docbuild -scheme SwiftToolbox -destination generic/platform=iOS DOCC_EXEC=/Users/adamwulf/Developer/swift/swift-docc/.build/arm64-apple-macosx/debug/docc OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path SwiftToolbox --output-path docs"
# xcodebuild docbuild -scheme SwiftToolbox -destination generic/platform=iOS DOCC_EXEC=/Users/adamwulf/Developer/swift/swift-docc/.build/arm64-apple-macosx/debug/docc OTHER_DOCC_FLAGS="--output-path .build/SwiftToolbox.doccarchive"

# building with extended types docc
# https://forums.swift.org/t/enablement-of-docc-extension-support-as-an-opt-in-feature/62614
#
xcrun -toolchain org.swift.57202301161a swift package --disable-sandbox generate-documentation --include-extended-types --disable-indexing --transform-for-static-hosting --hosting-base-path SwiftToolbox --output-path docs
xcrun -toolchain org.swift.57202301161a swift package --disable-sandbox generate-documentation --include-extended-types --output-path .build/SwiftToolbox.doccarchive
# format all json files in the Docs folder so that the built files are deterministic
find docs -name *.json -exec bash -c 'jq -M -c --sort-keys . < "{}" > "{}.temp"; mv "{}.temp" "{}"' \;
# open the documentation
open .build/SwiftToolbox.doccarchive
