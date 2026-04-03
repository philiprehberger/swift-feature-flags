# FeatureFlags

[![Tests](https://github.com/philiprehberger/swift-feature-flags/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/swift-feature-flags/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-feature-flags%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/philiprehberger/swift-feature-flags)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-feature-flags%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/philiprehberger/swift-feature-flags)

Type-safe feature flags with local defaults, remote overrides, and SwiftUI integration

## Requirements

- Swift >= 6.0
- macOS 13+ / iOS 16+ / tvOS 16+ / watchOS 9+

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/philiprehberger/swift-feature-flags.git", from: "0.1.0")
]
```

Then add `"FeatureFlags"` to your target dependencies:

```swift
.target(name: "YourTarget", dependencies: [
    .product(name: "FeatureFlags", package: "swift-feature-flags")
])
```

## Usage

```swift
import FeatureFlags

// Define flags with defaults
let registry = FlagRegistry()
await registry.register([
    LocalProvider(flags: [
        "dark_mode": true,
        "max_items": 50,
        "welcome_message": "Hello!"
    ])
])

// Check flags
let darkMode = await registry.isEnabled("dark_mode")  // => true
let maxItems: Int = await registry.value(for: "max_items", default: 10)  // => 50
```

### @Flag Property Wrapper

```swift
struct AppFlags {
    @Flag("dark_mode", default: false) var darkMode
    @Flag("max_items", default: 10) var maxItems
    @Flag("welcome_message", default: "Hi") var welcomeMessage
}
```

### Remote Overrides

```swift
let remote = RemoteProvider(url: URL(string: "https://api.example.com/flags.json")!)
await registry.register([
    LocalProvider(flags: ["dark_mode": false]),  // default
    remote  // overrides local when available
])
await try registry.refresh()  // fetch remote flags
```

### A/B Testing

```swift
let test = ABTest(key: "onboarding_flow", variants: ["control", "variant_a", "variant_b"])
let variant = test.variant(for: userId)  // deterministic per user
```

### Debug Overrides

```swift
await registry.override("dark_mode", value: true)  // force-enable for debugging
await registry.clearOverrides()
```

## API

### FlagRegistry

| Method | Description |
|--------|-------------|
| `register(_:)` | Register flag providers in priority order |
| `value(for:default:)` | Get a typed flag value with fallback |
| `isEnabled(_:)` | Check if a boolean flag is true |
| `refresh()` | Refresh all remote providers |
| `override(_:value:)` | Override a flag locally for debugging |
| `clearOverrides()` | Clear all manual overrides |

### FlagProvider

| Method | Description |
|--------|-------------|
| `value(for:)` | Return a flag value or nil |
| `refresh()` | Refresh flag data from source |

### ABTest

| Method | Description |
|--------|-------------|
| `variant(for:)` | Deterministic variant for a user ID |

## Development

```bash
swift build
swift test
```

## Support

[💬 Bluesky](https://bsky.app/profile/philiprehberger.bsky.social) · [🐦 X](https://x.com/philiprehberger) · [💼 LinkedIn](https://linkedin.com/in/philiprehberger) · [🌐 Website](https://philiprehberger.com) · [📦 GitHub](https://github.com/philiprehberger) · [☕ Buy Me a Coffee](https://buymeacoffee.com/philiprehberger) · [❤️ GitHub Sponsors](https://github.com/sponsors/philiprehberger)

## License

[MIT](LICENSE)
