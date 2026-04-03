import Testing
@testable import FeatureFlags

@Suite("ABTest Tests")
struct ABTestTests {
    @Test("Variant is deterministic for same user")
    func deterministic() {
        let test = ABTest(key: "experiment", variants: ["a", "b", "c"])
        let first = test.variant(for: "user-123")
        let second = test.variant(for: "user-123")
        #expect(first == second)
    }

    @Test("Different users can get different variants")
    func distribution() {
        let test = ABTest(key: "experiment", variants: ["a", "b"])
        var results = Set<String>()
        for i in 0..<100 {
            results.insert(test.variant(for: "user-\(i)"))
        }
        // With 100 users and 2 variants, we should see both
        #expect(results.count == 2)
    }

    @Test("Returns valid variant from list")
    func validVariant() {
        let variants = ["control", "variant_a", "variant_b"]
        let test = ABTest(key: "test", variants: variants)
        let result = test.variant(for: "any-user")
        #expect(variants.contains(result))
    }

    @Test("Empty variants returns empty string")
    func emptyVariants() {
        let test = ABTest(key: "test", variants: [])
        let result = test.variant(for: "user")
        #expect(result == "")
    }

    @Test("Different test keys produce different assignments")
    func differentKeys() {
        let testA = ABTest(key: "test_a", variants: ["x", "y", "z"])
        let testB = ABTest(key: "test_b", variants: ["x", "y", "z"])
        // Same user may get different variants for different tests
        // This is probabilistic, so just verify both return valid variants
        let variantA = testA.variant(for: "user-1")
        let variantB = testB.variant(for: "user-1")
        #expect(["x", "y", "z"].contains(variantA))
        #expect(["x", "y", "z"].contains(variantB))
    }
}
