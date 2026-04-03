import Foundation

/// A source of feature flag values
public protocol FlagProvider: Sendable {
    /// Return the value for a flag key, or nil if not set
    func value<T: FlagValue>(for key: String) -> T?

    /// Refresh flag data from the source
    func refresh() async throws
}

/// A flag provider backed by an in-memory dictionary of defaults
public final class LocalProvider: FlagProvider, @unchecked Sendable {
    private let flags: [String: any Sendable]

    /// Create a local provider with a dictionary of flag values
    public init(flags: [String: any Sendable]) {
        self.flags = flags
    }

    public func value<T: FlagValue>(for key: String) -> T? {
        flags[key] as? T
    }

    public func refresh() async throws {
        // No-op for local provider
    }
}
