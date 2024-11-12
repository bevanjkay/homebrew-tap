cask "mas-static" do
  version "1.8.7"
  sha256 "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}.arm64_sequoia.bottle.tar.gz"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  conflicts_with formula: "mas"
  depends_on macos: ">= :monterey"

  binary "mas/#{version}/bin/mas"

  # No zap stanza required
end
