# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SwiftToolbox is a Swift Package Manager library providing extensions and utilities for Apple platforms (iOS 12+, macOS 10.14+, Mac Catalyst 13+). The library focuses on extensions to Core Graphics, Foundation, UIKit, AppKit, and SwiftUI types, plus custom utilities for performance monitoring, form data handling, and SwiftUI helpers.

## Build and Development Commands

```bash
# Build the package
swift build -v

# Run tests (macOS)
swift test -v

# Run tests on iOS Simulator
xcodebuild build-for-testing -scheme SwiftToolbox -destination "platform=iOS Simulator,OS=latest,name=iPhone 12"
xcodebuild test-without-building -scheme SwiftToolbox -destination "platform=iOS Simulator,OS=latest,name=iPhone 12"

# Run tests on Mac Catalyst
xcodebuild build-for-testing -scheme SwiftToolbox -destination "platform=macOS,variant=Mac Catalyst"
xcodebuild test-without-building -scheme SwiftToolbox -destination "platform=macOS,variant=Mac Catalyst"

# Code formatting and linting
./format-files.sh    # Auto-fix formatting issues then lint
swiftlint           # Lint only

# Generate documentation 
./builddocs.sh      # Generates docs using custom DocC toolchain with extended types support
```

## Code Architecture

### Core Structure
- **SwiftToolbox.swift**: Main struct providing centralized logging infrastructure with configurable log levels and handlers
- **Extensions**: Category-based extensions organized by framework:
  - **Core Graphics**: CGRect, CGPoint, CGSize, CGVector, CGAffineTransform, CGContext, CGLine (custom type)
  - **Foundation**: String, Data, Array, Dictionary, FileManager, TimeInterval, UUID
  - **UIKit**: UIView, UIColor, UIImage, UIFont, UILabel, UITableView, UIBezierPath, etc.
  - **AppKit**: NSLayoutConstraint, NSToolbarItem
  - **SwiftUI**: OnFirstAppear modifier for one-time view appearance actions

### Custom Types and Utilities
- **Signpost**: Performance measurement wrapper around OSSignpost with event duration tracking and SwiftToolbox logging integration
- **ByteSize**: Enum with arithmetic operations for byte size representations
- **Clamping**: Property wrapper for constraining values within bounds
- **FormData**: HTTP multipart form data handling utilities
- **StopWatch**: Simple timing utility
- **PropertyListCompatible**: Protocol for property list serialization

### Testing Architecture
- **XCTest-based**: Standard unit test structure in `Tests/SwiftToolboxTests/`
- **Test Resources**: Binary test data files for FormData testing stored in `Tests/SwiftToolboxTests/Resources/`
- **Multi-platform Testing**: CI tests on macOS, iOS Simulator, and Mac Catalyst

## Code Style and Conventions

### SwiftLint Configuration
The project uses a relaxed SwiftLint configuration (`.swiftlint.yml`) that disables many standard rules to accommodate utility library patterns:
- **Disabled**: force_cast, cyclomatic_complexity, function_body_length, type_body_length, file_length, function_parameter_count
- **Line Length**: 140 character warning, 500 character error
- **Enabled Opt-in Rules**: empty_count, operator_usage_whitespace

### Documentation Standards
- Extensive DocC documentation with parameter descriptions for all public APIs
- Custom DocC toolchain with `--include-extended-types` flag for comprehensive extension documentation
- Availability annotations for platform-specific features
- Documentation generation uses a specific Swift toolchain: `org.swift.57202301161a`

### Dependencies and Package Management
- **Minimal Dependencies**: Only uses a custom fork of swift-docc-plugin for enhanced documentation
- **Package.swift**: Standard SPM manifest targeting Swift 5.7+ with multi-platform support
- **No External Runtime Dependencies**: Self-contained utility library

## Development Workflow Notes

- **CI Pipeline**: GitHub Actions with separate jobs for linting, macOS tests, iOS Simulator tests, and Mac Catalyst tests
- **Documentation Hosting**: Auto-generated docs hosted at GitHub Pages
- **Multi-platform Compatibility**: All code must work across iOS, macOS, and Mac Catalyst
- **Performance Focus**: Signpost utilities are central to the library's performance monitoring capabilities
- **Extension-First Design**: Most functionality is provided as extensions to existing Apple framework types rather than standalone utilities