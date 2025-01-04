cask "mas-static" do
  version "1.9.0"
  sha256 "3224ab0872dbcb77624c0cc33c2617d59c1d9b3707c0ec7f509b96ae54497b9e"

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
