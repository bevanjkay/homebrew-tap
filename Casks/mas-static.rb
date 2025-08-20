cask "mas-static" do
  version "2.3.0"
  sha256 "6cb062e9aedd5253bbeb7bcf0b84af27ce4cccc67c6760a1c356358f7b99a5bd"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}.pkg"

  uninstall pkgutil: "io.github.mas-cli"

  # No zap stanza required
end
