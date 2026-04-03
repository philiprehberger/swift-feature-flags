# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-02

### Added
- `FlagProvider` protocol for pluggable flag sources
- `LocalProvider` for defining flag defaults in code
- `RemoteProvider` for fetching flags from a JSON URL
- `FlagRegistry` actor for centralized flag resolution with provider priority
- `@Flag` property wrapper for type-safe flag access
- `FlagValue` protocol with Bool, String, Int, Double conformances
- `ABTest` struct for deterministic variant assignment by user ID
- Manual flag overrides for debugging
- SwiftUI environment integration via `FlagEnvironmentKey`
- Zero external dependencies
