import Foundation

/// Central registry that resolves flag values from registered providers
///
/// Providers are checked in reverse registration order — the last registered provider
/// that returns a non-nil value wins. This lets you layer local defaults under remote overrides.
public final class FlagRegistry: @unchecked Sendable {
    private var providers: [any FlagProvider] = []
    private var overrides: [String: any Sendable] = [:]
    private let lock = NSLock()

    /// Create a new flag registry
    public init() {}

    /// Register flag providers in priority order (later providers override earlier ones)
    public func register(_ providers: [any FlagProvider]) {
        lock.lock()
        self.providers.append(contentsOf: providers)
        lock.unlock()
    }

    /// Get a typed flag value, checking overrides first, then providers in reverse order
    public func value<T: FlagValue>(for key: String, default defaultValue: T) -> T {
        lock.lock()
        defer { lock.unlock() }

        // Check overrides first
        if let override = overrides[key] as? T {
            return override
        }

        // Check providers in reverse order (last registered wins)
        for provider in providers.reversed() {
            if let value: T = provider.value(for: key) {
                return value
            }
        }

        return defaultValue
    }

    /// Check if a boolean flag is enabled (defaults to false)
    public func isEnabled(_ key: String) -> Bool {
        value(for: key, default: false)
    }

    /// Refresh all remote providers
    public func refresh() async throws {
        let currentProviders: [any FlagProvider]
        lock.lock()
        currentProviders = providers
        lock.unlock()

        for provider in currentProviders {
            try await provider.refresh()
        }
    }

    /// Override a flag locally for debugging
    public func override(_ key: String, value: any FlagValue) {
        lock.lock()
        overrides[key] = value
        lock.unlock()
    }

    /// Clear all manual overrides
    public func clearOverrides() {
        lock.lock()
        overrides.removeAll()
        lock.unlock()
    }
}
