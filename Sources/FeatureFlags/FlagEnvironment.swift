#if canImport(SwiftUI)
import SwiftUI

/// SwiftUI environment key for accessing the flag registry
public struct FlagEnvironmentKey: EnvironmentKey {
    public static let defaultValue = FlagRegistry()
}

extension EnvironmentValues {
    /// The feature flag registry available in the SwiftUI environment
    public var flags: FlagRegistry {
        get { self[FlagEnvironmentKey.self] }
        set { self[FlagEnvironmentKey.self] = newValue }
    }
}
#endif
