# homebrew-openclaw

Homebrew tap for [OpenClaw](https://github.com/BenchAGI/openclaw) — Bench's multi-channel AI gateway.

## Install

```bash
brew tap benchagi/openclaw
brew install openclaw
```

Then:

```bash
openclaw models auth login         # authorize a default model provider
openclaw gateway start             # start the local gateway on :18789
curl http://localhost:18789/health # verify
```

## Upgrading

```bash
brew update
brew upgrade openclaw
```

## Source

Formula source of truth lives in the BenchAGI monorepo at [`tools/homebrew/openclaw.rb`](https://github.com/BenchAGI/BenchAGI_Mono_Repo/blob/main/tools/homebrew/openclaw.rb). This tap's `Formula/openclaw.rb` mirrors it on each release, with the SHA256 pinned to the release tarball.

The OpenClaw source is at [BenchAGI/openclaw](https://github.com/BenchAGI/openclaw).
