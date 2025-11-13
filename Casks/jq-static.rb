cask "jq-static" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.1"
  sha256 arm:   "a9fe3ea2f86dfc72f6728417521ec9067b343277152b114f4e98d8cb0e263603",
         intel: "e80dbe0d2a2597e3c11c404f03337b981d74b4a8504b70586c354b7697a7c27f"

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

  binary "jq-macos-#{arch}", target: "jq"

  # No zap stanza required
  # Debug
end
