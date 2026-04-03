import Foundation

/// A type that can be used as a feature flag value
public protocol FlagValue: Sendable, Codable {
    /// The type name for debugging
    static var flagType: String { get }
}

extension Bool: FlagValue {
    public static var flagType: String { "Bool" }
}

extension String: FlagValue {
    public static var flagType: String { "String" }
}

extension Int: FlagValue {
    public static var flagType: String { "Int" }
}

extension Double: FlagValue {
    public static var flagType: String { "Double" }
}
