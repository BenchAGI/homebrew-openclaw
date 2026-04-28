# Homebrew formula for OpenClaw — Bench's multi-channel AI gateway.
#
# Install (end-user):
#   brew tap benchagi/openclaw
#   brew install benchagi/openclaw/openclaw
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
  url "https://registry.npmjs.org/openclaw/-/openclaw-2026.4.26.tgz"
  sha256 "a1c0b9d417003b302d6c63bfc93d015784ad4b6a4a1360d1814ee1f5928ce3b4"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      Next steps:
        1. Authorize OpenClaw with your default model provider:
             openclaw models auth login
        2. Start the gateway (defaults to localhost:18789):
             openclaw gateway start
        3. Verify with:
             curl http://localhost:18789/health

      Config lives in ~/.openclaw/openclaw.json — Bench's deploy runbooks
      document the shape of that file per role (Aurelius, Cole, Sage, etc).

      Name collision note: always use the fully qualified name to install or
      upgrade (an unrelated openclaw cask exists in homebrew-cask):
        brew install benchagi/openclaw/openclaw
        brew upgrade benchagi/openclaw/openclaw
    EOS
  end

  test do
    # OpenClaw prints "OpenClaw <version> (<commit>)" to stdout for --version,
    # so we just assert the declared version appears in the output.
    assert_match version.to_s, shell_output("#{bin}/openclaw --version")
  end
end
