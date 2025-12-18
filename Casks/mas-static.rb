cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "4.1.1"
  sha256 arm:   "4c2262e345e7fd9a6ae85660b748bf0830606814a504ba45b3d777a69dc7732d",
         intel: "e4408b45e1f87bf957e46d4710424123b5de8416886df4465b7362fb2d32f371"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
