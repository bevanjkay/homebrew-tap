cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  version "3.0.1"
  sha256 arm:   "5eaf4edc13b33a077e47aecd74e2158157f64112f247834c32bbe8c4e8f09540",
         intel: "8736290c63267fceef7bd06356fb79ed687c4971107f0b2002c2b08e9db2df85"

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}.pkg"

  uninstall pkgutil: "io.github.mas-cli"

  # No zap stanza required
end
