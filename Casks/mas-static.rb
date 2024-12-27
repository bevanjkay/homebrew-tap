cask "mas-static" do
  version "1.8.8"
  sha256 "fa8842e1b4e875dbe33bc050c2cee88d1bca8f9d144f1ae7dfa55ac21b7facdb"

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
