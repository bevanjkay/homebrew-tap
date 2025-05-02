cask "mas-static" do
  version "2.2.2"
  sha256 "bfeb620f964c545cde4a1cae3adf12b37cb0ea9f158e8a4768c8a6390ce72faa"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  conflicts_with formula: "mas"
  depends_on macos: ">= :monterey"

  pkg "mas-#{version}.pkg"

  uninstall pkgutil: "io.github.mas-cli"

  # No zap stanza required
end
