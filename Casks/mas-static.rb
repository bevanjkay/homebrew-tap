cask "mas-static" do
  arch arm: "arm64", intel: "x86_64"

  on_monterey :or_older do
    version "4.1.2"
    sha256 arm:   "4e31579678c5878ddf5d203f7b55ddb8ab9f2edaefb07aae310fac65cf7ea715",
           intel: "89dd223c3920501e4509a288cda0955e1008b710e78cb33dbd6b25186fa94b03"
  end
  on_ventura :or_newer do
    version "7.0.0"
    sha256 arm:   "bc218a854c85d9e1c95496a96b26287bb66056b95688b90f91d04fa62ed21b75",
           intel: "9bca1de1fb6ea19c9e0b9d7b7c85249020c9ed65a9d434c2ef40896a2f3395f9"
  end

  url "https://github.com/mas-cli/mas/releases/download/v#{version}/mas-#{version}-#{arch}.pkg"
  name "mas-static"
  desc "Command-line interface for the App Store"
  homepage "https://github.com/mas-cli/mas"

  depends_on macos: :monterey

  pkg "mas-#{version}-#{arch}.pkg"

  uninstall pkgutil: "io.github.mas-cli.mas"

  # No zap stanza required
end
