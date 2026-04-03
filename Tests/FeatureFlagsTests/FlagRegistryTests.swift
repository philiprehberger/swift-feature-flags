import Testing
@testable import FeatureFlags

@Suite("FlagRegistry Tests")
struct FlagRegistryTests {
    @Test("Returns default value when no providers registered")
    func defaultValue() {
        let registry = FlagRegistry()
        let value: Bool = registry.value(for: "missing", default: false)
        #expect(value == false)
    }

    @Test("Returns value from local provider")
    func localProvider() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["dark_mode": true])
        registry.register([provider])
        let value: Bool = registry.value(for: "dark_mode", default: false)
        #expect(value == true)
    }

    @Test("Later providers override earlier ones")
    func providerPriority() {
        let registry = FlagRegistry()
        let first = LocalProvider(flags: ["dark_mode": false])
        let second = LocalProvider(flags: ["dark_mode": true])
        registry.register([first, second])
        let value: Bool = registry.value(for: "dark_mode", default: false)
        #expect(value == true)
    }

    @Test("isEnabled returns boolean flag value")
    func isEnabled() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["feature_x": true])
        registry.register([provider])
        #expect(registry.isEnabled("feature_x") == true)
        #expect(registry.isEnabled("missing") == false)
    }

    @Test("Override takes precedence over providers")
    func overridePrecedence() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["dark_mode": false])
        registry.register([provider])
        registry.override("dark_mode", value: true)
        #expect(registry.isEnabled("dark_mode") == true)
    }

    @Test("Clear overrides removes all manual overrides")
    func clearOverrides() {
        let registry = FlagRegistry()
        registry.override("dark_mode", value: true)
        #expect(registry.isEnabled("dark_mode") == true)
        registry.clearOverrides()
        #expect(registry.isEnabled("dark_mode") == false)
    }

    @Test("Returns default when provider has no value for key")
    func providerMissingKey() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["other": true])
        registry.register([provider])
        let value: Int = registry.value(for: "max_items", default: 10)
        #expect(value == 10)
    }
}
