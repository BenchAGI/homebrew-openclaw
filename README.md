# homebrew-openclaw — DEPRECATED

> **This tap is deprecated.** Use the canonical `benchagi/tap` instead.

## Migrate

```bash
brew untap benchagi/openclaw
brew tap benchagi/tap
brew install benchagi/tap/openclaw
```

The canonical tap lives at [BenchAGI/homebrew-tap](https://github.com/BenchAGI/homebrew-tap). It follows the Homebrew multi-formula convention (same pattern as `hashicorp/tap`, `aws/tap`) and will host all future BenchAGI formulae.

## Why the move

- Matches Homebrew convention for org-level taps with multiple formulae
- Aligns with the BenchAGI launch-readiness drift check (`tier-b-installer-available`), which expects `brew tap benchagi/tap` to resolve
- Scales: no new tap repo per tool

## Automatic migration

The `openclaw` formula has been removed from this tap. `tap_migrations.json` maps
`openclaw` → `benchagi/tap/openclaw`, so existing installs from this tap migrate to the
canonical tap automatically on `brew update && brew upgrade` — no manual untap required
(though the explicit migration above is still the cleanest path).

This repository is now a migration stub with no Formula or source code. CodeQL default
setup is intentionally disabled here; security scanning for the `openclaw` formula now
runs in the canonical `benchagi/tap` repository.

The BenchAGI team plans to archive this repo after end-to-end verification of the new tap. Migrate now to avoid the archive cutover.
