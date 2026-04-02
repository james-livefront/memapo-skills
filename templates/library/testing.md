# Testing

- setTimeout in tests causes flakiness; use waitFor or explicit condition checks
- Test rejection/invalid cases before acceptance cases for validation logic
- Mocking at the network layer is more stable than mocking internal functions
