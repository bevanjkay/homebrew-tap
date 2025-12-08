cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "4.1.0"
  sha256 arm:   "f3369938f382c8b1ce1661e1be2257232e52079b6ba9033f3051e107dca08a54",
         intel: "f46900576822b6ab59ec4c3f4155c38f7b434db879bb00713ed61d2d29ee7191"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
