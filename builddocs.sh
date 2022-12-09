xcodebuild docbuild -scheme SwiftToolbox -destination generic/platform=iOS DOCC_EXEC=/Users/adamwulf/Developer/swift/swift-docc/.build/arm64-apple-macosx/debug/docc OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path SwiftToolbox --output-path docs"
xcodebuild docbuild -scheme SwiftToolbox -destination generic/platform=iOS DOCC_EXEC=/Users/adamwulf/Developer/swift/swift-docc/.build/arm64-apple-macosx/debug/docc OTHER_DOCC_FLAGS="--output-path .build/SwiftToolbox.doccarchive"
# format all json files in the Docs folder so that the built files are deterministic
find Docs -name *.json -exec bash -c 'jq -M -c --sort-keys . < "{}" > "{}.temp"; mv "{}.temp" "{}"' \;
# open the documentation
open .build/SwiftToolbox.doccarchive
