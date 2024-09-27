cask "jq-static" do
  arch arm: "arm64", intel: "amd64"

  version "1.7.1"
  sha256 arm:   "0bbe619e663e0de2c550be2fe0d240d076799d6f8a652b70fa04aea8a8362e8a",
         intel: "4155822bbf5ea90f5c79cf254665975eb4274d426d0709770c21774de5407443"

  url "https://github.com/jqlang/jq/releases/download/jq-#{version}/jq-macos-#{arch}",
      verified: "github.com/jqlang/jq/"
  name "jq"
  desc "JSON processor"
  homepage "https://jqlang.github.io/jq/"

  conflicts_with formula: "jq"

  binary "jq-macos-#{arch}", target: "jq"

  # No zap stanza required
end
