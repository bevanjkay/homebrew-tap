cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "5.0.1"
  sha256 arm:   "86f38e62db5d7d426ed390bbdfac164fc94e77b146560a8551d420b85d99628a",
         intel: "8aa93375d7e6fd3abce97371d9410f166e4ee683956876cc7abe6ae24cbe7182"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
