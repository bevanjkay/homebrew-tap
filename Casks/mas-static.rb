cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  on_monterey :or_older do
    version "4.1.2"
    sha256 arm:   "4e31579678c5878ddf5d203f7b55ddb8ab9f2edaefb07aae310fac65cf7ea715",
           intel: "89dd223c3920501e4509a288cda0955e1008b710e78cb33dbd6b25186fa94b03"
  end
  on_ventura :or_newer do
    version "5.2.0"
    sha256 arm:   "d17aee6b9aaad7e6bb0c1cba5e16fd5838e80509310963c525001e0f7b5756db",
           intel: "cbdc5f8a53c460ebb5ce0d2bc7421c95f51ecbfc0e071446d1fc80edaaf12e95"
  end

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: ">= :monterey"

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
