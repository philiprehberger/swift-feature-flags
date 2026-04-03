import Testing
@testable import FeatureFlags

@Suite("LocalProvider Tests")
struct LocalProviderTests {
    @Test("Returns stored value for key")
    func returnsValue() {
        let provider = LocalProvider(flags: ["flag": true])
        let value: Bool? = provider.value(for: "flag")
        #expect(value == true)
    }

    @Test("Returns nil for missing key")
    func missingKey() {
        let provider = LocalProvider(flags: [:])
        let value: Bool? = provider.value(for: "missing")
        #expect(value == nil)
    }

    @Test("Returns nil for wrong type")
    func wrongType() {
        let provider = LocalProvider(flags: ["flag": "hello"])
        let value: Int? = provider.value(for: "flag")
        #expect(value == nil)
    }

    @Test("Supports multiple value types")
    func multipleTypes() {
        let provider = LocalProvider(flags: [
            "bool": true,
            "string": "hello",
            "int": 42,
            "double": 3.14
        ])
        let boolVal: Bool? = provider.value(for: "bool")
        let stringVal: String? = provider.value(for: "string")
        let intVal: Int? = provider.value(for: "int")
        let doubleVal: Double? = provider.value(for: "double")
        #expect(boolVal == true)
        #expect(stringVal == "hello")
        #expect(intVal == 42)
        #expect(doubleVal == 3.14)
    }
}
