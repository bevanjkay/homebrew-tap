cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  on_monterey :or_older do
    version "4.1.2"
    sha256 arm:   "4e31579678c5878ddf5d203f7b55ddb8ab9f2edaefb07aae310fac65cf7ea715",
           intel: "89dd223c3920501e4509a288cda0955e1008b710e78cb33dbd6b25186fa94b03"
  end
  on_ventura :or_newer do
    version "6.0.1"
    sha256 arm:   "059f5413c1f6f248ea88c35d2c3514c82f6669d478ac157598b506ca3ea89776",
           intel: "efe88306be061b96dd4ee025026310904908cd580ba36f8311dadabc295a2ed4"
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
