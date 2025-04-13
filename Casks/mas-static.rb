cask "mas-static" do
  version "2.0.0"
  sha256 "ffcc397025191798e098a4d91df7af9c174d1370a10bbe7dc95e56b19986c3a8"

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
