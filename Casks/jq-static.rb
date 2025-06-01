cask "jq-static" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.0"
  sha256 arm:   "aaf1efbb376d6e3eaf61f63807c32c1df519f5857dfc4f581826fa2df4b715ae",
         intel: "a594f3740bf570f0dbc43ff102a9034c17719d1bb5b40f0192751234d67f172a"

  on_intel do
    postflight do
      system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/jq"
    end
  end

  url "https://github.com/jqlang/jq/releases/download/jq-#{version}/jq-macos-#{arch}",
      verified: "github.com/jqlang/jq/"
  name "jq"
  desc "JSON processor"
  homepage "https://jqlang.github.io/jq/"

  conflicts_with formula: "jq"

  binary "jq-macos-#{arch}", target: "jq"

  # No zap stanza required
end
