# Homebrew formula for OpenClaw — Bench's multi-channel AI gateway.
#
# DEPRECATED: this tap (benchagi/openclaw) has been superseded by the
# canonical multi-formula tap benchagi/tap. Migrate with:
#
#   brew untap benchagi/openclaw
#   brew tap benchagi/tap
#   brew install benchagi/tap/openclaw
#
# This formula is kept in place to avoid breaking existing users who
# already tapped benchagi/openclaw, but new users should use the
# canonical tap. See https://github.com/BenchAGI/homebrew-tap.
#
# Note the tap-prefixed install command: an unrelated `openclaw` cask exists
# in homebrew-cask (an old WarCraft-style game remake) that collides on the
# short name, so bare `brew install openclaw` resolves to the cask. Always
# use the fully qualified name to disambiguate.
#
# Source: the public `openclaw` npm package (upstream), which ships with
# pre-built `dist/`. Once we publish the BenchAGI fork to npm as
# @benchagi/openclaw, this formula switches over and picks up the
# memory-wiki and other Bench-specific patches. For now the install path
# is npm-upstream to give users a working gateway today.
class Openclaw < Formula
  desc "Multi-channel AI gateway with extensible messaging integrations"
  homepage "https://github.com/BenchAGI/openclaw"
  url "https://registry.npmjs.org/openclaw/-/openclaw-2026.4.15.tgz"
  sha256 "8c95f77538130c77967c970da4744786c4d5b773937b8208f622efb4cf0d2564"
  license "MIT"

  deprecate! date: "2026-04-20", because: "this tap moved to benchagi/tap; run `brew untap benchagi/openclaw && brew tap benchagi/tap && brew install benchagi/tap/openclaw`"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      This tap (benchagi/openclaw) is DEPRECATED. Migrate to benchagi/tap:

        brew untap benchagi/openclaw
        brew tap benchagi/tap
        brew install benchagi/tap/openclaw

      After install, next steps:
        1. Authorize OpenClaw with your default model provider:
             openclaw models auth login
        2. Start the gateway (defaults to localhost:18789):
             openclaw gateway start
        3. Verify with:
             curl http://localhost:18789/health

      Config lives in ~/.openclaw/openclaw.json — Bench's deploy runbooks
      document the shape of that file per role (Aurelius, Cole, Sage, etc).
    EOS
  end

  test do
    # OpenClaw prints "OpenClaw <version> (<commit>)" to stdout for --version,
    # so we just assert the declared version appears in the output.
    assert_match version.to_s, shell_output("#{bin}/openclaw --version")
  end
end
