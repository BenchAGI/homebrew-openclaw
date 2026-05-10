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

## Still here

The `openclaw` formula remains in `Formula/openclaw.rb` so existing tappers don't hit a resolution error. It is marked `deprecate!` with a pointer to the new tap, so `brew install` or `brew upgrade` will print a migration notice.

The BenchAGI team plans to archive this repo after end-to-end verification of the new tap. Migrate now to avoid the archive cutover.
