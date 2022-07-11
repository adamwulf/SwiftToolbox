xcodebuild docbuild -scheme SwiftToolbox -destination generic/platform=iOS OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path SwiftToolbox --output-path docs"
xcodebuild docbuild -scheme SwiftToolbox -destination generic/platform=iOS OTHER_DOCC_FLAGS="--output-path .build/SwiftToolbox.doccarchive"
open .build/SwiftToolbox.doccarchive
