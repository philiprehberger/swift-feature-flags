import Testing
@testable import FeatureFlags

@Suite("Flag Property Wrapper Tests")
struct FlagPropertyWrapperTests {
    @Test("Flag returns default value with empty registry")
    func defaultValue() {
        let registry = FlagRegistry()
        let flag = Flag("test_flag", default: 42, registry: registry)
        #expect(flag.wrappedValue == 42)
    }

    @Test("Flag returns provider value when available")
    func providerValue() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["test_flag": 99])
        registry.register([provider])
        let flag = Flag("test_flag", default: 42, registry: registry)
        #expect(flag.wrappedValue == 99)
    }

    @Test("Flag works with Bool type")
    func boolFlag() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["enabled": true])
        registry.register([provider])
        let flag = Flag("enabled", default: false, registry: registry)
        #expect(flag.wrappedValue == true)
    }

    @Test("Flag works with String type")
    func stringFlag() {
        let registry = FlagRegistry()
        let provider = LocalProvider(flags: ["greeting": "Hello"])
        registry.register([provider])
        let flag = Flag("greeting", default: "Hi", registry: registry)
        #expect(flag.wrappedValue == "Hello")
    }
}
