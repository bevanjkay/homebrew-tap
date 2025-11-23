cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "3.1.0"
  sha256 arm:   "51a01a5d6767769b94d6dccf55be9b02d3b5c073ce317118e87a38c8566d4b8e",
         intel: "1fe738fa66f9e1a05e1e70feebe5e93ea577cb94859fcb82a5dc8add5d316d08"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
