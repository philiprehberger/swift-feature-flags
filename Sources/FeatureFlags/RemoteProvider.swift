import Foundation

/// A flag provider that fetches flags from a JSON URL
///
/// The JSON response must be a flat object with string keys and primitive values:
/// ```json
/// { "dark_mode": true, "max_items": 50, "welcome": "Hello" }
/// ```
public final class RemoteProvider: @unchecked Sendable, FlagProvider {
    private let url: URL
    private let session: URLSession
    private var cache: [String: Any] = [:]
    private let lock = NSLock()

    /// Create a remote provider that fetches flags from a JSON URL
    public init(url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    public func value<T: FlagValue>(for key: String) -> T? {
        lock.lock()
        defer { lock.unlock() }
        return cache[key] as? T
    }

    /// Fetch flags from the remote URL and update the local cache
    public func refresh() async throws {
        let (data, _) = try await session.data(from: url)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        lock.lock()
        cache = json
        lock.unlock()
    }
}
