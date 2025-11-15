### Testing

Back to README: [../README.md](../README.md)

### Types

- Widget tests: `test/widget_test.dart` present as a sample
- Unit tests: add under `test/**`
- Integration tests: not configured; consider `integration_test` package

### Commands

```bash
flutter test
flutter test --coverage
```

### CI

- Not defined in this repo; consider adding GitHub Actions or similar.

### Test data/mocks

- Create fakes for Services; inject into Providers or expose seams to replace network layers during tests.

### Missing info

- No existing integration tests; coverage thresholds are not defined.
