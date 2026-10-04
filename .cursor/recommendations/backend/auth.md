---
id: backend.auth
scope: backend
status: active
---

# Password hashing

## Rule

Hash secrets with hash_secret and check them with verify_secret. Both use PBKDF2-HMAC-SHA512, 100000 iterations, and a random salt stored with the hash. verify_secret raises WrongSecret on a mismatch. Session tokens are JWT RS256. The auth package to add is mpxnkauth. The sample is in the auth rule.

## Why

Password checks and token checks stay in one utility.

## Exceptions

An API key for an integration is a setting, not a user password. Do not run it through hash_secret.
