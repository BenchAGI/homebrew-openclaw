# Homebrew formula for OpenClaw — Bench's multi-channel AI gateway.
#
# Canonical home for this formula is the dedicated tap repo
# github.com/BenchAGI/homebrew-openclaw (tap directive: `brew tap
# benchagi/openclaw`). This copy lives in the monorepo so the formula
# evolves with the rest of the deploy pipeline; CI copies it to the tap
# repo when a release cuts.
#
# Install (end-user):
#   brew tap benchagi/openclaw
#   brew install openclaw
#
# Upgrade: `brew upgrade openclaw` (the formula's `url` pin on tag means
# `brew` knows when a newer release is available).
#
# See docs/homebrew-tap-setup.md for the tap repo bootstrap + release flow.
class Openclaw < Formula
  desc "Multi-channel AI gateway with extensible messaging integrations"
  homepage "https://github.com/BenchAGI/openclaw"
  url "https://github.com/BenchAGI/openclaw/archive/refs/tags/v2026.4.18.tar.gz"
  sha256 "0be31497ab5946d5b3489f6a5823d127659c7160aa705ca87e04ef0ca70cd601"
  license "MIT"
  head "https://github.com/BenchAGI/openclaw.git", branch: "main"

  depends_on "node"

  def install
    # std_npm_args handles the libexec + PATH wiring that Homebrew expects
    # for Node-based CLIs; we then symlink the `openclaw` binary from the
    # libexec install tree into Homebrew's bin directory so users get it
    # on their PATH without extra config.
    system "npm", "install", *std_npm_args(prefix: false)
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
    EOS
  end

  test do
    # OpenClaw prints "OpenClaw <version> (<commit>)" to stdout for --version,
    # so we just assert the declared version appears in the output.
    assert_match version.to_s, shell_output("#{bin}/openclaw --version")
  end
end
