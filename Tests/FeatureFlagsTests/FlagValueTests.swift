import Testing
@testable import FeatureFlags

@Suite("FlagValue Tests")
struct FlagValueTests {
    @Test("Bool conforms to FlagValue")
    func boolType() {
        #expect(Bool.flagType == "Bool")
    }

    @Test("String conforms to FlagValue")
    func stringType() {
        #expect(String.flagType == "String")
    }

    @Test("Int conforms to FlagValue")
    func intType() {
        #expect(Int.flagType == "Int")
    }

    @Test("Double conforms to FlagValue")
    func doubleType() {
        #expect(Double.flagType == "Double")
    }
}
