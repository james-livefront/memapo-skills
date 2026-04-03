# Library Index

Quick scan of all insights. See topic files for full context.

## testing
- setTimeout causes flakiness; use waitFor or explicit conditions
- Test rejection cases before acceptance cases for validation logic
- Mocking at network layer is more stable than mocking internal functions

## apis
- Pagination doesn't guarantee order without ORDER BY
- Rate limits often apply per-endpoint, not just per-account
- Webhook signatures should be verified before parsing payload

## debugging
- Race conditions often manifest as "works locally, fails in CI"
- When a bug seems impossible, check for multiple instances/processes
- Binary search through commits (git bisect) beats guessing
