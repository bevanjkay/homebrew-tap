cask "mas-static" do
  version "2.2.0"
  sha256 "4debc8d5010e2e842905c3b9cd834d539766a4a6b8a1be414f3da79229a2e6d8"

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
