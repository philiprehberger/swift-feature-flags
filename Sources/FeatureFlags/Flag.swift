import Foundation

/// A property wrapper for type-safe feature flag access
///
/// ```swift
/// struct AppFlags {
///     @Flag("dark_mode", default: false) var darkMode
///     @Flag("max_items", default: 10) var maxItems
/// }
/// ```
@propertyWrapper
public struct Flag<T: FlagValue>: Sendable {
    /// The flag key used for lookup
    public let key: String

    /// The default value when no provider has the flag
    public let defaultValue: T

    private let registry: FlagRegistry

    /// The current flag value
    public var wrappedValue: T {
        registry.value(for: key, default: defaultValue)
    }

    /// Create a flag backed by the shared registry
    public init(_ key: String, default value: T, registry: FlagRegistry = FlagRegistry()) {
        self.key = key
        self.defaultValue = value
        self.registry = registry
    }
}
