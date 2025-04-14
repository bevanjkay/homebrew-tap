cask "mas-static" do
  version "2.1.0"
  sha256 "a53f16fd974d3fb16fe67c935fdbca6d36b68c89374c73751d50a6b842226df7"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  conflicts_with formula: "mas"
  depends_on macos: ">= :monterey"

  pkg "mas-#{version}.pkg"

  uninstall pkgutil: "com.mphys.mas-cli"

  # No zap stanza required
end
