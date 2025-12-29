cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "5.0.2"
  sha256 arm:   "b1deee20815c8cad9ea6da42136f7fc30010d94f33b63f85ae835b160eb317d5",
         intel: "903892ad8238aeb849e45f1ce452b09dc0467f77fe545c719f592f77356c187c"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
