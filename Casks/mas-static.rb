cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "4.0.0"
  sha256 arm:   "4f7272751aa41a0804a3cabc340e7f469b1f23e04dce245d7fcc7f6c8980fb20",
         intel: "42c2c2b1d16f8cabe5d24a0349aac1313c871420a8ea577f581c4c0186005d3c"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
