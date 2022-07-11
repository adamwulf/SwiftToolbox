swift package  --allow-writing-to-directory ./docs  generate-documentation  --target SwiftToolbox --output-path ./docs  --transform-for-static-hosting  --hosting-base-path SwiftToolbox
swift package generate-documentation
open .build/plugins/Swift-DocC/outputs/SwiftToolbox.doccarchive
