cask "mas-static" do
  version "1.8.7"
  sha256 "4680a9a03325c626896e65b4c922c68a7f96a87163d226ea7dbd55ddb076a7a1"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  conflicts_with formula: "mas"
  depends_on macos: ">= :high_sierra"

  pkg "mas.pkg"

  uninstall pkgutil: "com.mphys.mas-cli"

  # No zap stanza required
end
