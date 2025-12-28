cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "5.0.0"
  sha256 arm:   "2261833c491a98daa578fcb281d494b9830f2b9c60691b0916b1bf6bdd4e4cf2",
         intel: "743d0510eb6d459c63cfd4138683324723fcbfc131bce7320491f28e4314b60b"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
