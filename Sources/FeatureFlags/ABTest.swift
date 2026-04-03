import Foundation

/// Deterministic A/B test variant assignment
///
/// Assigns a variant to each user based on a hash of the test key and user ID,
/// ensuring the same user always sees the same variant.
///
/// ```swift
/// let test = ABTest(key: "onboarding_flow", variants: ["control", "variant_a", "variant_b"])
/// let variant = test.variant(for: "user-123")  // deterministic
/// ```
public struct ABTest: Sendable {
    /// The test identifier
    public let key: String

    /// The available variants
    public let variants: [String]

    /// Create an A/B test with a key and variant list
    public init(key: String, variants: [String]) {
        self.key = key
        self.variants = variants
    }

    /// Get the deterministic variant for a user identifier
    ///
    /// Uses a hash of `key + userId` to assign a consistent variant.
    /// Returns the first variant if `variants` is empty (should not happen).
    public func variant(for userId: String) -> String {
        guard !variants.isEmpty else { return "" }
        let combined = "\(key):\(userId)"
        var hash: UInt64 = 5381
        for byte in combined.utf8 {
            hash = hash &* 33 &+ UInt64(byte)
        }
        let index = Int(hash % UInt64(variants.count))
        return variants[index]
    }
}
